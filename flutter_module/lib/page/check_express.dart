import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_module/util/keep_alive_wrapper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../util/dio_util.dart';
import '../data/bill_data.dart';

class CheckExpress extends StatefulWidget {
  const CheckExpress({super.key});

  @override
  State<CheckExpress> createState() => _CheckExpressState();
}

class _CheckExpressState extends State<CheckExpress>
    with SingleTickerProviderStateMixin, PageVisibilityObserver {
  late TabController _tabController;
  late VoidCallback removeListener;
  bool shouldPop = true;
  List tabs = ["全部", "进行中", "已完成", "已取消"];
  late ScrollController _list_controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      //点击tab时或滑动tab回调一次
      if (_tabController.index.toDouble() == _tabController.animation?.value) {
        print("切换到第 ${_tabController.index + 1} 个菜单");
      }
    });

    _list_controller = ScrollController();
    //监听滚动事件，打印滚动位置  pixels == maxScrollExtent，且停止滑动，表明滑动List底部
    _list_controller.addListener(() {//pixels == 0，且停止滑动，表明滑动List顶部
      print("max offset ${_list_controller.positions.elementAt(0).maxScrollExtent}"); //可滑动的最大位置
      print("offset ${_list_controller.positions.elementAt(0).pixels}"); //打印滚动位置
    });


    //添加事件响应者,监听native发往flutter端的事件
    removeListener = BoostChannel.instance.addEventListener("eventToFlutter",
        (String key, Map arguments) {
      return Future.delayed(const Duration(seconds: 0), () {
        print("eventToFlutter: ${arguments['data']}");
        return arguments['data'];
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //注册监听器
    PageVisibilityBinding.instance
        .addObserver(this, ModalRoute.of(context) as Route);
  }

  @override
  void didUpdateWidget(covariant CheckExpress oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    //屏幕适配初始化
    ScreenUtil.init(context, designSize: const Size(390, 844));
    return WillPopScope(
        onWillPop: () async {
          return shouldPop;
        },
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              SizedBox(
                width: ScreenUtil().setWidth(78),
                height: ScreenUtil().setWidth(44),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  splashRadius: 25,
                  onPressed: () {
                    closeCurrentPage();
                  },
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(234),
                height: ScreenUtil().setWidth(44),
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.grey.shade200),
                    // 设置颜色无效
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 18)),

                    foregroundColor: MaterialStateProperty.resolveWith(
                      (states) {
                        if (states.contains(MaterialState.pressed)) {
                          ////按下时的颜色
                          return Colors.black;
                        }
                        //默认状态使用灰色
                        return Colors.black;
                      },
                    ),

                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      //设置按下时的背景颜色
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.white;
                      }
                      //默认不使用背景颜色
                      return Colors.white;
                    }),
                  ),
                  onPressed: () {
                    clickCheckExpress();
                  },
                  child: const Text(
                    "查件",
                    style: TextStyle(color: Color(0xFF000000)),
                  ),
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(78),
                height: ScreenUtil().setWidth(44),
                child: TextButton(
                  style: ButtonStyle(
                    // 此处不设置颜色，设置颜色由foregroundColor，backgroundColor完成
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 18)),
                    //设置水波纹颜色
                    overlayColor: MaterialStateProperty.resolveWith(
                      (states) {
                        return Colors.transparent; //不用水波纹，设置为透明
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (states) {
                        if (states.contains(MaterialState.pressed)) {
                          ////按下时的颜色
                          return Colors.black;
                        }
                        //默认状态使用灰色
                        return Colors.black;
                      },
                    ),

                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      //设置按下时的背景颜色
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.white;
                      }
                      //默认不使用背景颜色
                      return Colors.white;
                    }),
                  ),
                  child: const Text("寄件",
                      style: TextStyle(color: Color(0xFF000000))),
                  onPressed: () {
                    jumpReservationExpressPage();
                  },
                ),
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF000000),
              indicatorColor: const Color(0xFFFABE00),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 4.0,
              labelStyle: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF222222),
                  fontWeight: FontWeight.w500),
              unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w400),
              tabs: tabs.map((e) => Tab(text: e)).toList(),
            ),
          ),
          body: TabBarView(
            //构建
            controller: _tabController,
            children: [
              KeepAliveWrapper(
                child: ListView.builder(
                  controller: _list_controller,
                  itemCount: allBillData.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < allBillData.length) {
                      return updateBillDataWidget(allBillData[index]);
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(15.0),
                        child: const Text(
                          "没有更多了",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                  },
                ),
              ),
              KeepAliveWrapper(
                child: ListView.builder(
                  itemCount: doingBillData.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < doingBillData.length) {
                      return updateBillDataWidget(doingBillData[index]);
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(15.0),
                        child: const Text(
                          "没有更多了",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                  },
                ),
              ),
              KeepAliveWrapper(
                child: ListView.builder(
                  itemCount: doneBillData.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < doneBillData.length) {
                      return updateBillDataWidget(doneBillData[index]);
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(15.0),
                        child: const Text(
                          "没有更多了",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                  },
                ),
              ),
              KeepAliveWrapper(
                child: ListView.builder(
                  itemCount: cancelBillData.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < cancelBillData.length) {
                      return updateBillDataWidget(cancelBillData[index]);
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(15.0),
                        child: const Text(
                          "没有更多了",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    // 释放资源
    _tabController.dispose();
    _list_controller.dispose();
    //移除监听器
    PageVisibilityBinding.instance.removeObserver(this);
    removeListener?.call();
    super.dispose();
  }

  requestUserData() {
    Map<String, Object> params = {
      "appid": "g7r6lo3qji4ue8rx",
      "action": "ydAccountApi.pinganAccount.queryPinganAcountStatus",
      "version": "V1.0",
      "req_time": DateTime.now().millisecondsSinceEpoch,
      "data": {
        "userId": "QFRlo9aXcbIUXcqEMjDcyHzgzZdcoxrB",
      }
    };

    DioUtil().postRequest(data: params).then((value) => print(value));
  }

  Widget updateBillDataWidget(Map<String, Object> billData) {
    switch (billData['orderStatus']) {
      case "UN_TAKEN": //待取件
        return updateUnTakeBillWidget(billData);
      case "UN_PAY": //待支付
        return updateUnPayBillWidget(billData);
      case "IN_TRANSIT": //运输中
        return updateInTransitBillWidget(billData);
      case "SIGNED": //已签收
        return updateSignedBillWidget(billData);
      case "CANCELED": //已取消
        return updateCancelBillWidget(billData);
      default:
        return const SizedBox();
    }
  }

  Widget updateUnTakeBillWidget(Map<String, Object> billData) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Container(
          height: ScreenUtil().setWidth(280),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "运单号 ",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.w200),
                      ),
                      Text(billData['orderNo'].toString(),
                          style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF222222),
                              fontWeight: FontWeight.w400)),
                      const Image(
                        image: AssetImage("images/copy.png"),
                        width: 16.0,
                        height: 16.0,
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: ScreenUtil().setWidth(280),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                            child: Text(billData['senderCity'].toString(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w500))),
                      ),
                      const Expanded(
                          flex: 1,
                          child: Center(
                            child: Image(
                              image: AssetImage("images/un_take.png"),
                              width: 48,
                              height: 10,
                            ),
                          )),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(billData['receiverCity'].toString(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF222222),
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  width: ScreenUtil().setWidth(280),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                            child: Text(billData['senderName'].toString(),
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.w400))),
                      ),
                      const Expanded(
                          flex: 1,
                          child: Center(
                            child: Text("待取件",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w400)),
                          )),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(billData['receiverName'].toString(),
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF999999),
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15),
                child: Row(
                  children: [
                    const Text("预约上门时间  ",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.w400)),
                    Text("${billData['operateTime']}前",
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF222222),
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15),
                child: Container(
                  width: ScreenUtil().setWidth(334),
                  height: ScreenUtil().setWidth(44),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFF5F5F5),
                  ),
                  alignment: Alignment.center,
                  child: Text.rich(TextSpan(children: [
                    const TextSpan(
                        text: "取件码 ",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.w400)),
                    TextSpan(
                        text: billData['collectCode'].toString(),
                        style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xFF222222),
                            fontWeight: FontWeight.w400)),
                    const TextSpan(
                        text: " 快递员上门取件时出示此码",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.w400)),
                  ])),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  width: ScreenUtil().setWidth(366),
                  height: ScreenUtil().setWidth(1),
                  color: const Color(0xFFEEEEEE),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          showCancelConfirmDialog();
                        },
                        style: ButtonStyle(
                          ///设置文本不同状态时颜色
                          foregroundColor: MaterialStateProperty.resolveWith(
                            (states) {
                              if (states.contains(MaterialState.pressed)) {
                                //按下时的颜色
                                return const Color(0xFF222222);
                              }
                              //默认状态使用灰色
                              return const Color(0xFF222222);
                            },
                          ),
                          //按钮背景颜色
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            //设置按下时的背景颜色
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.grey.shade400;
                            }
                            //默认不使用背景颜色
                            return null;
                          }),

                          ///设置水波纹颜色
                          overlayColor: MaterialStateProperty.all(
                              const Color(0xFFDDDDDD)),

                          ///按钮大小
                          // minimumSize: MaterialStateProperty.all(const Size(320, 36)),
                          ///设置按钮圆角
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),

                          ///设置按钮边框颜色和宽度
                          side: MaterialStateProperty.all(const BorderSide(
                              color: Color(0xFFDDDDDD), width: 1)),
                        ),
                        child: const Text("取消订单")),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget updateUnPayBillWidget(Map<String, Object> billData) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Container(
          height: ScreenUtil().setWidth(255),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "运单号 ",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.w200),
                      ),
                      Text(billData['orderNo'].toString(),
                          style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF222222),
                              fontWeight: FontWeight.w400)),
                      const Image(
                        image: AssetImage("images/copy.png"),
                        width: 16.0,
                        height: 16.0,
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: ScreenUtil().setWidth(280),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                            child: Text(billData['senderCity'].toString(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w500))),
                      ),
                      const Expanded(
                          flex: 1,
                          child: Center(
                            child: Image(
                              image: AssetImage("images/un_take.png"),
                              width: 48,
                              height: 10,
                            ),
                          )),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(billData['receiverCity'].toString(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF222222),
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  width: ScreenUtil().setWidth(280),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                            child: Text(billData['senderName'].toString(),
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.w400))),
                      ),
                      const Expanded(
                          flex: 1,
                          child: Center(
                            child: Text("待取件",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w400)),
                          )),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(billData['receiverName'].toString(),
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF999999),
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15),
                child: Row(
                  children: [
                    const Text("下单时间  ",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.w400)),
                    Text(billData['operateTime'].toString(),
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF222222),
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(children: [
                      const TextSpan(
                          text: "待支付  ",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF999999),
                              fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: '￥${billData['payFee']}',
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFFE34444),
                              fontWeight: FontWeight.w400)),
                    ])),
                    Row(
                      children: const [
                        Text("费用明细",
                            style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFFBBBBBB),
                                fontWeight: FontWeight.w400)),
                        Image(
                          image: AssetImage("images/payment_detail.png"),
                          width: 14,
                          height: 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  width: ScreenUtil().setWidth(366),
                  height: ScreenUtil().setWidth(1),
                  color: const Color(0xFFEEEEEE),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: OutlinedButton(
                          onPressed: () {
                            showCancelConfirmDialog();
                          },
                          style: ButtonStyle(
                            ///设置文本不同状态时颜色
                            foregroundColor: MaterialStateProperty.resolveWith(
                              (states) {
                                if (states.contains(MaterialState.pressed)) {
                                  //按下时的颜色
                                  return const Color(0xFF222222);
                                }
                                //默认状态使用灰色
                                return const Color(0xFF222222);
                              },
                            ),
                            //按钮背景颜色
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              //设置按下时的背景颜色
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.grey.shade400;
                              }
                              //默认不使用背景颜色
                              return null;
                            }),

                            ///设置水波纹颜色
                            overlayColor: MaterialStateProperty.all(
                                const Color(0xFFDDDDDD)),

                            ///按钮大小
                            // minimumSize: MaterialStateProperty.all(const Size(320, 36)),
                            ///设置按钮圆角
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),

                            ///设置按钮边框颜色和宽度
                            side: MaterialStateProperty.all(const BorderSide(
                                color: Color(0xFFDDDDDD), width: 1)),
                          ),
                          child: const Text("取消订单")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: OutlinedButton(
                          onPressed: () {
                            jumpFreightDetailPage();
                          },
                          style: ButtonStyle(
                            ///设置文本不同状态时颜色
                            foregroundColor: MaterialStateProperty.resolveWith(
                              (states) {
                                if (states.contains(MaterialState.pressed)) {
                                  //按下时的颜色
                                  return const Color(0xFF222222);
                                }
                                //默认状态使用灰色
                                return const Color(0xFF222222);
                              },
                            ),
                            //按钮背景颜色
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              //设置按下时的背景颜色
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.yellow.shade600;
                              }
                              //默认不使用背景颜色
                              return const Color(0xFFFABE00);
                            }),

                            ///设置水波纹颜色
                            overlayColor: MaterialStateProperty.all(
                                Colors.yellow.shade600),

                            ///按钮大小
                            // minimumSize: MaterialStateProperty.all(const Size(320, 36)),
                            ///设置按钮圆角
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),

                            ///设置按钮边框颜色和宽度
                            side: MaterialStateProperty.all(const BorderSide(
                                color: Color(0xFFDDDDDD), width: 1)),
                          ),
                          child: const Text("立即支付")),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget updateInTransitBillWidget(Map<String, Object> billData) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Container(
          height: ScreenUtil().setWidth(255),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "运单号 ",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.w200),
                      ),
                      Text(billData['orderNo'].toString(),
                          style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF222222),
                              fontWeight: FontWeight.w400)),
                      const Image(
                        image: AssetImage("images/copy.png"),
                        width: 16.0,
                        height: 16.0,
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: ScreenUtil().setWidth(280),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                            child: Text(billData['senderCity'].toString(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w500))),
                      ),
                      const Expanded(
                          flex: 1,
                          child: Center(
                            child: Image(
                              image: AssetImage("images/trannsit.png"),
                              width: 48,
                              height: 10,
                            ),
                          )),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(billData['receiverCity'].toString(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF222222),
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  width: ScreenUtil().setWidth(280),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                            child: Text(billData['senderName'].toString(),
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.w400))),
                      ),
                      const Expanded(
                          flex: 1,
                          child: Center(
                            child: Text("运输中",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w400)),
                          )),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(billData['receiverName'].toString(),
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF999999),
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15),
                child: Row(
                  children: [
                    const Text("下单时间  ",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.w400)),
                    Text(billData['operateTime'].toString(),
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF222222),
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(children: [
                      const TextSpan(
                          text: "已支付  ",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF999999),
                              fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: "￥${billData['payFee']}",
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF222222),
                              fontWeight: FontWeight.w400)),
                    ])),
                    Row(
                      children: const [
                        Text("费用明细",
                            style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFFBBBBBB),
                                fontWeight: FontWeight.w400)),
                        Image(
                          image: AssetImage("images/payment_detail.png"),
                          width: 14,
                          height: 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  width: ScreenUtil().setWidth(366),
                  height: ScreenUtil().setWidth(1),
                  color: const Color(0xFFEEEEEE),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: OutlinedButton(
                          onPressed: () {
                            jumpExpressTrackPage();
                          },
                          style: ButtonStyle(
                            ///设置文本不同状态时颜色
                            foregroundColor: MaterialStateProperty.resolveWith(
                              (states) {
                                if (states.contains(MaterialState.pressed)) {
                                  //按下时的颜色
                                  return const Color(0xFF222222);
                                }
                                //默认状态使用灰色
                                return const Color(0xFF222222);
                              },
                            ),
                            //按钮背景颜色
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              //设置按下时的背景颜色
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.grey.shade400;
                              }
                              //默认不使用背景颜色
                              return null;
                            }),

                            ///设置水波纹颜色
                            overlayColor: MaterialStateProperty.all(
                                const Color(0xFFDDDDDD)),

                            ///按钮大小
                            // minimumSize: MaterialStateProperty.all(const Size(320, 36)),
                            ///设置按钮圆角
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),

                            ///设置按钮边框颜色和宽度
                            side: MaterialStateProperty.all(const BorderSide(
                                color: Color(0xFFDDDDDD), width: 1)),
                          ),
                          child: const Text("查看物流")),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget updateSignedBillWidget(Map<String, Object> billData) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Container(
          height: ScreenUtil().setWidth(255),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "运单号 ",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.w200),
                      ),
                      Text(billData['orderNo'].toString(),
                          style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF222222),
                              fontWeight: FontWeight.w400)),
                      const Image(
                        image: AssetImage("images/copy.png"),
                        width: 16.0,
                        height: 16.0,
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: ScreenUtil().setWidth(280),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                            child: Text(billData['senderCity'].toString(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w500))),
                      ),
                      const Expanded(
                          flex: 1,
                          child: Center(
                            child: Image(
                              image: AssetImage("images/signed.png"),
                              width: 48,
                              height: 10,
                            ),
                          )),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(billData['receiverCity'].toString(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF222222),
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  width: ScreenUtil().setWidth(280),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                            child: Text(billData['senderName'].toString(),
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.w400))),
                      ),
                      const Expanded(
                          flex: 1,
                          child: Center(
                            child: Text("已签收",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w400)),
                          )),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(billData['receiverName'].toString(),
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF999999),
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15),
                child: Row(
                  children: [
                    const Text("下单时间  ",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.w400)),
                    Text(billData['operateTime'].toString(),
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF222222),
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(children: [
                      const TextSpan(
                          text: "已支付  ",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF999999),
                              fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: "￥${billData['payFee']}",
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF222222),
                              fontWeight: FontWeight.w400)),
                    ])),
                    Row(
                      children: const [
                        Text("费用明细",
                            style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFFBBBBBB),
                                fontWeight: FontWeight.w400)),
                        Image(
                          image: AssetImage("images/payment_detail.png"),
                          width: 14,
                          height: 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  width: ScreenUtil().setWidth(366),
                  height: ScreenUtil().setWidth(1),
                  color: const Color(0xFFEEEEEE),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: OutlinedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            ///设置文本不同状态时颜色
                            foregroundColor: MaterialStateProperty.resolveWith(
                              (states) {
                                if (states.contains(MaterialState.pressed)) {
                                  //按下时的颜色
                                  return const Color(0xFF222222);
                                }
                                //默认状态使用灰色
                                return const Color(0xFF222222);
                              },
                            ),
                            //按钮背景颜色
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              //设置按下时的背景颜色
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.grey.shade400;
                              }
                              //默认不使用背景颜色
                              return null;
                            }),

                            ///设置水波纹颜色
                            overlayColor: MaterialStateProperty.all(
                                const Color(0xFFDDDDDD)),

                            ///按钮大小
                            // minimumSize: MaterialStateProperty.all(const Size(320, 36)),
                            ///设置按钮圆角
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),

                            ///设置按钮边框颜色和宽度
                            side: MaterialStateProperty.all(const BorderSide(
                                color: Color(0xFFDDDDDD), width: 1)),
                          ),
                          child: const Text("删除")),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget updateCancelBillWidget(Map<String, Object> billData) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Container(
          height: ScreenUtil().setWidth(225),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "运单号 ",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.w200),
                      ),
                      Text(billData['orderNo'].toString(),
                          style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF222222),
                              fontWeight: FontWeight.w400)),
                      const Image(
                        image: AssetImage("images/copy.png"),
                        width: 16.0,
                        height: 16.0,
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: ScreenUtil().setWidth(280),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                            child: Text(billData['senderCity'].toString(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w500))),
                      ),
                      const Expanded(
                          flex: 1,
                          child: Center(
                            child: Image(
                              image: AssetImage("images/cancel.png"),
                              width: 48,
                              height: 10,
                            ),
                          )),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(billData['receiverCity'].toString(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF222222),
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  width: ScreenUtil().setWidth(280),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                            child: Text(billData['senderName'].toString(),
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.w400))),
                      ),
                      const Expanded(
                          flex: 1,
                          child: Center(
                            child: Text("已取消",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w400)),
                          )),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(billData['receiverName'].toString(),
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF999999),
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15),
                child: Row(
                  children: [
                    const Text("取消时间  ",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.w400)),
                    Text(billData['operateTime'].toString(),
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF222222),
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  width: ScreenUtil().setWidth(366),
                  height: ScreenUtil().setWidth(1),
                  color: const Color(0xFFEEEEEE),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: OutlinedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            ///设置文本不同状态时颜色
                            foregroundColor: MaterialStateProperty.resolveWith(
                              (states) {
                                if (states.contains(MaterialState.pressed)) {
                                  //按下时的颜色
                                  return const Color(0xFF222222);
                                }
                                //默认状态使用灰色
                                return const Color(0xFF222222);
                              },
                            ),
                            //按钮背景颜色
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              //设置按下时的背景颜色
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.grey.shade400;
                              }
                              //默认不使用背景颜色
                              return null;
                            }),

                            ///设置水波纹颜色
                            overlayColor: MaterialStateProperty.all(
                                const Color(0xFFDDDDDD)),

                            ///按钮大小
                            // minimumSize: MaterialStateProperty.all(const Size(320, 36)),
                            ///设置按钮圆角
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),

                            ///设置按钮边框颜色和宽度
                            side: MaterialStateProperty.all(const BorderSide(
                                color: Color(0xFFDDDDDD), width: 1)),
                          ),
                          child: const Text("删除")),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  //BoostNavigator.instance.pop(true);
  // 弹出对话框
  Future<bool?> showCancelConfirmDialog() {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true, //点击遮罩时是否关闭
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: ScreenUtil().setWidth(270),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                    child: Text("取消订单",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(12)),
                    child: Text("确定要取消该笔寄件订单吗？",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(12),
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                    child: Container(
                      color: const Color(0xFFBBBBBB),
                      width: ScreenUtil().setWidth(270),
                      height: ScreenUtil().setWidth(1),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Material(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15)),
                            child: InkWell(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(15)),
                              splashColor: Colors.grey.shade600,
                              radius: 0, //水波纹半径,显示触点
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15)),
                                ),
                                height: ScreenUtil().setWidth(44),
                                alignment: Alignment.center,
                                child: Text("取消",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(16),
                                        color: const Color(0xFF666666),
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.none)),
                              ),
                              onTap: () {
                                BoostNavigator.instance.pop(true);
                              },
                            ),
                          )),
                      Container(
                        width: ScreenUtil().setWidth(1),
                        height: ScreenUtil().setWidth(44),
                        color: const Color(0xFFBBBBBB),
                      ),
                      Expanded(
                          flex: 1,
                          child: Material(
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(15)),
                            child: InkWell(
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(15)),
                              splashColor: Colors.grey.shade600,
                              radius: 0, //水波纹半径,显示触点
                              onTap: () {},
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15)),
                                ),
                                height: ScreenUtil().setWidth(44),
                                alignment: Alignment.center,
                                child: Text("确认",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(16),
                                        color: const Color(0xFF222222),
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.none)),
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  @override
  void onBackground() {
    super.onBackground();
    print("CheckExpress - onBackground");
  }

  @override
  void onForeground() {
    super.onForeground();
    print("CheckExpress - onForeground");
  }

  @override
  void onPageHide() {
    super.onPageHide();
    print("CheckExpress - onPageHide");
  }

  @override
  void onPageShow() {
    super.onPageShow();
    print("CheckExpress - onPageShow");
  }

  closeCurrentPage() {
    debugPrint("closeCurrentPage");
    BoostNavigator.instance.pop();
  }

  //给原生发消息
  clickCheckExpress() {
    debugPrint("clickCheckExpress");
    BoostChannel.instance.sendEventToNative("eventToNative",{"key1":"value1"});
  }

  // name	页面在路由表中的名字
  // withContainer	是否需伴随原生容器弹出
  // arguments	携带到下一页面的参数
  // opaque	页面是否透明(下面会再次提到)
  jumpExpressTrackPage() {
    BoostNavigator.instance.push(
      "express_track", //required
      withContainer: false, //optional
      arguments: {"key": "value"}, //optional
      opaque: true, //optional,default value is true
    );
  }

  jumpFreightDetailPage() {
    BoostNavigator.instance.push(
      "freight_detail", //required
      withContainer: false, //optional
      arguments: {"key": "value"}, //optional
      opaque: true, //optional,default value is true
    );
  }

  jumpReservationExpressPage() {
    BoostNavigator.instance.push(
      "reservation_express", //required
      withContainer: false, //optional
      arguments: {"key": "value"}, //optional
      opaque: true, //optional,default value is true
    );
  }

  jumpToNativePage() {
    BoostNavigator.instance.push(
      "native_screen", //required
      withContainer: false, //optional
      arguments: {"key": "value"}, //optional
      opaque: true, //optional,default value is true
    );
  }
}
