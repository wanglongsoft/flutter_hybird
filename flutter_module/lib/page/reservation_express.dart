import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import '../data/bill_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationExpress extends StatefulWidget {
  const ReservationExpress({super.key});

  @override
  State<ReservationExpress> createState() => _ReservationExpressState();
}

class _ReservationExpressState extends State<ReservationExpress> {
  bool _is_agree_to_sign = false;
  String _sign_icon_url = "images/un_select.png";
  String _sender_name_phone = "填写寄件人信息";
  String _sender_address = "点击此处填写寄件人信息";
  String _recipient_name_phone = "填写收件人信息";
  String _recipient_address = "点击此处填写收件人信息";
  bool _is_order_success = false;

  @override
  Widget build(BuildContext context) {
    //屏幕适配初始化
    ScreenUtil.init(context, designSize: const Size(390, 844));
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          SizedBox(
            width: ScreenUtil().setWidth(78),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              splashRadius: 25,
              onPressed: () {
                BoostNavigator.instance.pop();
              },
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(234),
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                // 设置颜色无效
                textStyle:
                    MaterialStateProperty.all(const TextStyle(fontSize: 18)),

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

                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  //设置按下时的背景颜色
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.white;
                  }
                  //默认不使用背景颜色
                  return Colors.white;
                }),
              ),
              onPressed: () {},
              child: const Text(
                "预约寄件",
                style: TextStyle(color: Color(0xFF000000)),
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(78),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setWidth(12),
                left: ScreenUtil().setWidth(12),
              ),
              child: Container(
                width: ScreenUtil().setWidth(366),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(12)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setWidth(20),
                          left: ScreenUtil().setWidth(16),
                          right: ScreenUtil().setWidth(16),
                          bottom: ScreenUtil().setWidth(20)),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Image(
                                  image: const AssetImage("images/send.png"),
                                  fit: BoxFit.fitHeight,
                                  width: ScreenUtil().setWidth(24),
                                  height: ScreenUtil().setWidth(24),
                                ),
                              ),
                              Expanded(
                                flex: 14,
                                child: GestureDetector(
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(_sender_name_phone,
                                            style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(16),
                                                color: const Color(0xFF222222),
                                                fontWeight: FontWeight.w400)),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: ScreenUtil().setWidth(12),
                                          ),
                                          child: Text(_sender_address,
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(12),
                                                  color:
                                                      const Color(0xFF999999),
                                                  fontWeight: FontWeight.w400)),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () async {//异步，否者收不到返回值
                                    dynamic result = await BoostNavigator.instance.push(
                                      "edit_recipient_sender", //required
                                      withContainer: false, //optional
                                      arguments: {
                                        "title": "编辑寄件人",
                                        "type": "send"
                                      }, //optional
                                      opaque: true, //optional,default value is true
                                    );
                                    if(null == result || result['type'] == null) {
                                      return;
                                    }
                                    setState(() {
                                      _sender_name_phone = "${result['name']} ${result['phone']}";
                                      _sender_address = "${result['province_city_area']} ${result['address']}";
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(1),
                                height: ScreenUtil().setWidth(40),
                                color: const Color(0xFFEEEEEE),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    Image(
                                      image: const AssetImage(
                                          "images/address.png"),
                                      width: ScreenUtil().setWidth(24),
                                      height: ScreenUtil().setWidth(24),
                                    ),
                                    Text("地址簿",
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(12),
                                            color: const Color(0xFF999999),
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                            child: Row(
                              children: [
                                const Expanded(flex: 3, child: SizedBox()),
                                Expanded(
                                  flex: 17,
                                  child: Container(
                                    height: ScreenUtil().setWidth(1),
                                    color: const Color(0xFFEEEEEE),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Image(
                                    image:
                                        const AssetImage("images/receive.png"),
                                    fit: BoxFit.fitHeight,
                                    width: ScreenUtil().setWidth(24),
                                    height: ScreenUtil().setWidth(24),
                                  ),
                                ),
                                Expanded(
                                  flex: 14,
                                  child: GestureDetector(
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(_recipient_name_phone,
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(16),
                                                  color:
                                                      const Color(0xFF222222),
                                                  fontWeight: FontWeight.w400)),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: ScreenUtil().setWidth(12),
                                            ),
                                            child: Text(_recipient_address,
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color:
                                                        const Color(0xFF999999),
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () async {
                                      dynamic result = await BoostNavigator.instance.push(
                                        "edit_recipient_sender", //required
                                        withContainer: false, //optional
                                        arguments: {
                                          "title": "编辑收件人",
                                          "type": "recipient"
                                        }, //optional
                                        opaque: true, //optional,default value is true
                                      );
                                      if(null == result || result['type'] == null) {
                                        return;
                                      }
                                      setState(() {
                                        _recipient_name_phone = "${result['name']} ${result['phone']}";
                                        _recipient_address = "${result['province_city_area']} ${result['address']}";
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(1),
                                  height: ScreenUtil().setWidth(40),
                                  color: const Color(0xFFEEEEEE),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      Image(
                                        image: const AssetImage(
                                            "images/address.png"),
                                        width: ScreenUtil().setWidth(24),
                                        height: ScreenUtil().setWidth(24),
                                      ),
                                      Text("地址簿",
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(12),
                                              color: const Color(0xFF999999),
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setWidth(12),
                left: ScreenUtil().setWidth(12),
              ),
              child: Container(
                width: ScreenUtil().setWidth(366),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(16),
                      right: ScreenUtil().setWidth(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("商品信息",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(16),
                                        color: const Color(0xFF222222),
                                        fontWeight: FontWeight.w500)),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(5)),
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        ScreenUtil().setWidth(6),
                                        ScreenUtil().setWidth(2),
                                        ScreenUtil().setWidth(6),
                                        ScreenUtil().setWidth(2)),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFE34444),
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setWidth(10))),
                                    child: Text("必填",
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(12),
                                            color: const Color(0xFFFFFFFF),
                                            fontWeight: FontWeight.w400)),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text("请选择",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(16),
                                        color: const Color(0xFFBBBBBB),
                                        fontWeight: FontWeight.w400)),
                                Image(
                                  image: const AssetImage(
                                      "images/right_arrow.png"),
                                  fit: BoxFit.fitHeight,
                                  width: ScreenUtil().setWidth(24),
                                  height: ScreenUtil().setWidth(24),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: ScreenUtil().setWidth(1),
                                  color: const Color(0xFFEEEEEE),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                        child: Text("快递类型",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(16),
                                color: const Color(0xFF222222),
                                fontWeight: FontWeight.w500)),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setWidth(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: ScreenUtil().setWidth(160),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setWidth(8)),
                                border:
                                    Border.all(color: const Color(0xFFFABE00)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFABE00),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            ScreenUtil().setWidth(17)),
                                        bottomRight: Radius.circular(
                                            ScreenUtil().setWidth(17)),
                                      ),
                                    ),
                                    padding: EdgeInsets.fromLTRB(
                                        ScreenUtil().setWidth(20),
                                        ScreenUtil().setWidth(5),
                                        ScreenUtil().setWidth(20),
                                        ScreenUtil().setWidth(7)),
                                    child: Text("特惠寄",
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(12),
                                            color: const Color(0xFF222222),
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setWidth(14)),
                                    child: Text("当天取件",
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(14),
                                            color: const Color(0xFF222222),
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: ScreenUtil().setWidth(10),
                                      bottom: ScreenUtil().setWidth(18),
                                    ),
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "预估 ",
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(16),
                                              color: const Color(0xFF222222),
                                              fontWeight: FontWeight.w500)),
                                      TextSpan(
                                          text: '￥10',
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(16),
                                              color: const Color(0xFFE34444),
                                              fontWeight: FontWeight.w500)),
                                      TextSpan(
                                          text: " 起",
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(16),
                                              color: const Color(0xFF222222),
                                              fontWeight: FontWeight.w500)),
                                    ])),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: ScreenUtil().setWidth(160),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setWidth(8)),
                                border:
                                    Border.all(color: const Color(0xFFDDDDDD)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDDDDDD),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            ScreenUtil().setWidth(17)),
                                        bottomRight: Radius.circular(
                                            ScreenUtil().setWidth(17)),
                                      ),
                                    ),
                                    padding: EdgeInsets.fromLTRB(
                                        ScreenUtil().setWidth(20),
                                        ScreenUtil().setWidth(5),
                                        ScreenUtil().setWidth(20),
                                        ScreenUtil().setWidth(7)),
                                    child: Text("时效寄",
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(12),
                                            color: const Color(0xFF666666),
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setWidth(14)),
                                    child: Text("2小时内上门取件",
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(14),
                                            color: const Color(0xFF999999),
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: ScreenUtil().setWidth(10),
                                      bottom: ScreenUtil().setWidth(18),
                                    ),
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "预估 ",
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(16),
                                              color: const Color(0xFF999999),
                                              fontWeight: FontWeight.w500)),
                                      TextSpan(
                                          text: '￥10',
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(16),
                                              color: const Color(0xFF999999),
                                              fontWeight: FontWeight.w500)),
                                      TextSpan(
                                          text: " 起",
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(16),
                                              color: const Color(0xFF999999),
                                              fontWeight: FontWeight.w500)),
                                    ])),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: ScreenUtil().setWidth(1),
                                  color: const Color(0xFFEEEEEE),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("期望上门时间",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(16),
                                        color: const Color(0xFF222222),
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            Row(
                              children: [
                                Text("今天 2小时内",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(16),
                                        color: const Color(0xFF666666),
                                        fontWeight: FontWeight.w400)),
                                Image(
                                  image: const AssetImage(
                                      "images/right_arrow.png"),
                                  fit: BoxFit.fitHeight,
                                  width: ScreenUtil().setWidth(24),
                                  height: ScreenUtil().setWidth(24),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: ScreenUtil().setWidth(1),
                                  color: const Color(0xFFEEEEEE),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setWidth(20),
                            bottom: ScreenUtil().setWidth(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("付款方式",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(16),
                                        color: const Color(0xFF222222),
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            Row(
                              children: [
                                Text("寄件现结",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(16),
                                        color: const Color(0xFF666666),
                                        fontWeight: FontWeight.w400)),
                                Image(
                                  image: const AssetImage(
                                      "images/right_arrow.png"),
                                  fit: BoxFit.fitHeight,
                                  width: ScreenUtil().setWidth(24),
                                  height: ScreenUtil().setWidth(24),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setWidth(100),
                left: ScreenUtil().setWidth(12),
                bottom: ScreenUtil().setWidth(100),
              ),
              child: Container(
                width: ScreenUtil().setWidth(366),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: "预估费用 ",
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(12),
                                    color: const Color(0xFF222222),
                                    fontWeight: FontWeight.w400)),
                            TextSpan(
                                text: '￥',
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: const Color(0xFFE34444),
                                    fontWeight: FontWeight.w500)),
                            TextSpan(
                                text: '11.00',
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(20),
                                    color: const Color(0xFFE34444),
                                    fontWeight: FontWeight.w500)),
                          ])),
                          Padding(
                            padding:
                                EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: _updateSignIconUrl,
                                  child: Image(
                                    image: AssetImage(_sign_icon_url),
                                    fit: BoxFit.fitHeight,
                                    width: ScreenUtil().setWidth(16),
                                    height: ScreenUtil().setWidth(16),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _updateSignIconUrl,
                                  child: Text("我已阅读并同意",
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(12),
                                          color: const Color(0xFF999999),
                                          fontWeight: FontWeight.w400)),
                                ),
                                GestureDetector(
                                  onTap: _showContractTerms,
                                  child: Text("《合约条款》",
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(12),
                                          color: const Color(0xFF222222),
                                          fontWeight: FontWeight.w400)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          if(_is_order_success) {
                            _is_order_success = false;

                            BoostNavigator.instance.push(
                              "order_result", //required
                              withContainer: false, //optional
                              arguments: {
                                "title": "下单失败",
                                "type" : "fail",
                                "reason": "美国一位学者曾经分析了数千人的经历，总人数的98%都是失败者。"
                              }, //optional
                              opaque: true, //optional,default value is true
                            );
                          } else {
                            _is_order_success = true;
                            BoostNavigator.instance.push(
                              "order_result", //required
                              withContainer: false, //optional
                              arguments: {
                                "title": "下单成功",
                                "type" : "success",
                                "reason": ""
                              }, //optional
                              opaque: true, //optional,default value is true
                            );
                          }
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              const Color(0xFFFAB000)),
                          // 设置颜色无效
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: ScreenUtil().setSp(20))),

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
                              return const Color(0xFFFABE00);
                            }
                            //默认不使用背景颜色
                            return const Color(0xFFFABE00);
                          }),

                          ///设置按钮圆角
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil().setWidth(22)))),

                          ///按钮大小
                          minimumSize: MaterialStateProperty.all(Size(
                              ScreenUtil().setWidth(100),
                              ScreenUtil().setWidth(44))),
                        ),
                        child: const Text(
                          "下单",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateSignIconUrl() {
    setState(() {
      if (_is_agree_to_sign) {
        _is_agree_to_sign = false;
        _sign_icon_url = "images/un_select.png";
      } else {
        _is_agree_to_sign = true;
        _sign_icon_url = "images/selected.png";
      }
    });
  }

  Future<bool?> _showContractTerms() {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true, //点击遮罩时是否关闭
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: ScreenUtil().setWidth(390),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ScreenUtil().setWidth(15)),
                    topRight: Radius.circular(ScreenUtil().setWidth(15))),
              ),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                      child: Text("合约条款",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(18),
                              decoration: TextDecoration.none,
                              color: const Color(0xFF222222),
                              fontWeight: FontWeight.w500))),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                    child: Container(
                      height: ScreenUtil().setWidth(1),
                      width: ScreenUtil().setWidth(390),
                      color: const Color(0xFFEEEEEE),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                      child: Column(
                        children: contractData
                            .map((e) => updateContractDataWidget(e))
                            .toList(),
                      )),
                  Padding(
                    padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(34)),
                    child: TextButton(
                        onPressed: () {
                          _updateSignIconUrl();
                          BoostNavigator.instance.pop(true);
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              const Color(0xFFFAB000)),
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
                              return const Color(0xFFFABE00);
                            }
                            //默认不使用背景颜色
                            return const Color(0xFFFABE00);
                          }),

                          ///设置按钮圆角
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil().setWidth(22)))),

                          ///按钮大小
                          minimumSize: MaterialStateProperty.all(Size(
                              ScreenUtil().setWidth(358),
                              ScreenUtil().setWidth(44))),
                        ),
                        child: const Text(
                          "我已阅读并同意",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget updateContractDataWidget(String data) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(16),
          right: ScreenUtil().setWidth(16),
          bottom: ScreenUtil().setWidth(20)),
      child: Text(
        data,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(14),
            decoration: TextDecoration.none,
            color: const Color(0xFF666666),
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
