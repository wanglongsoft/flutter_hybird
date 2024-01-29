import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import '../data/province_city_area_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditRecipientSender extends StatefulWidget {
  final Map argument;

  const EditRecipientSender({required this.argument, super.key});

  @override
  State<StatefulWidget> createState() => _EditRecipientSenderState();
}

class _EditRecipientSenderState extends State<EditRecipientSender> {
  List<Map<String, String>> _province_data = [];
  List<Map<String, String>> _city_data = [];
  List<Map<String, String>> _area_data = [];
  int _province_index = 0;
  int _city_index = 0;
  final FixedExtentScrollController _province_controller =
      FixedExtentScrollController();
  final FixedExtentScrollController _city_controller =
      FixedExtentScrollController();
  final FixedExtentScrollController _area_controller =
      FixedExtentScrollController();

  String? _province_city_area = "省市区";
  String? _user_name = "";
  String? _user_phone = "";
  String? _user_address = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resetPvovinceCityAreaData();
  }

  @override
  Widget build(BuildContext context) {
    //屏幕适配初始化
    ScreenUtil.init(context, designSize: const Size(390, 844));
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
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
              child: Text(
                widget.argument['title'],
                style: const TextStyle(color: Color(0xFF000000)),
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(78),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(12)),
            child: Container(
              width: ScreenUtil().setWidth(366),
              padding: EdgeInsets.all(ScreenUtil().setWidth(12)),
              decoration: BoxDecoration(
                  color: const Color(0x33FABE00),
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(12))),
              child: Text(
                "温馨提示：依照《邮件快件实名收寄管理办法》的规定，填写的寄件人姓名与您的实名信息保持一致",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(12),
                    color: const Color(0xFFE34444),
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(12)),
            child: Container(
              width: ScreenUtil().setWidth(366),
              padding: EdgeInsets.all(ScreenUtil().setWidth(12)),
              decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(12))),
              child: Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(16),
                    right: ScreenUtil().setWidth(16)),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "姓名",
                        hintStyle: TextStyle(
                            fontSize: ScreenUtil().setWidth(16),
                            color: const Color(0xFF999999),
                            fontWeight: FontWeight.w400),
                        enabledBorder: const UnderlineInputBorder(
                          // 不是焦点的时候颜色
                          borderSide: BorderSide(color: Color(0xFFEEEEEE)),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          // 焦点集中的时候颜色
                          borderSide: BorderSide(color: Color(0xFFEEEEEE)),
                        ),
                      ),
                      onChanged: (name) {
                        _user_name = name;
                      },
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "手机或固话",
                        hintStyle: TextStyle(
                            fontSize: ScreenUtil().setWidth(16),
                            color: const Color(0xFF999999),
                            fontWeight: FontWeight.w400),
                        enabledBorder: const UnderlineInputBorder(
                          // 不是焦点的时候颜色
                          borderSide: BorderSide(color: Color(0xFFEEEEEE)),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          // 焦点集中的时候颜色
                          borderSide: BorderSide(color: Color(0xFFEEEEEE)),
                        ),
                      ),
                      onChanged: (phone) {
                        _user_phone = phone;
                      },
                    ),
                    GestureDetector(
                      onTap: _showSelectModalPopup,
                      child: Container(
                          color: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: ScreenUtil().setWidth(18),
                              bottom: ScreenUtil().setWidth(18),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _province_city_area!,
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setWidth(16),
                                      color: _province_city_area == "省市区"
                                          ? const Color(0xFF999999)
                                          : const Color(0xFF222222),
                                      fontWeight: FontWeight.w400),
                                ),
                                Image(
                                  image: const AssetImage(
                                      "images/right_arrow.png"),
                                  fit: BoxFit.fitHeight,
                                  width: ScreenUtil().setWidth(24),
                                  height: ScreenUtil().setWidth(24),
                                ),
                              ],
                            ),
                          )),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(334),
                      height: ScreenUtil().setWidth(1),
                      color: const Color(0xFFEEEEEE),
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: "详细地址（详细到镇、街道、门牌号）",
                        hintStyle: TextStyle(
                            fontSize: ScreenUtil().setWidth(16),
                            color: const Color(0xFF999999),
                            fontWeight: FontWeight.w400),
                        enabledBorder: const UnderlineInputBorder(
                          // 不是焦点的时候颜色
                          borderSide: BorderSide(color: Color(0xFFEEEEEE)),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          // 焦点集中的时候颜色
                          borderSide: BorderSide(color: Color(0xFFEEEEEE)),
                        ),
                      ),
                      onChanged: (address) {
                        _user_address = address;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(12),
                top: ScreenUtil().setWidth(12),
                right: ScreenUtil().setWidth(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.grey.shade100),

                    textStyle: MaterialStateProperty.all(
                        TextStyle(fontSize: ScreenUtil().setSp(20))),

                    foregroundColor: MaterialStateProperty.resolveWith(
                      (states) {
                        if (states.contains(MaterialState.pressed)) {
                          ////按下时的颜色
                          return const Color(0XFF666666);
                        }
                        //默认状态使用灰色
                        return const Color(0XFF666666);
                      },
                    ),

                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      //设置按下时的背景颜色
                      if (states.contains(MaterialState.pressed)) {
                        return const Color(0xFFFFFFFF);
                      }
                      //默认不使用背景颜色
                      return const Color(0xFFFFFFFF);
                    }),

                    //设置按钮圆角
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(10)))),

                    //按钮大小
                    minimumSize: MaterialStateProperty.all(Size(
                        ScreenUtil().setWidth(76), ScreenUtil().setWidth(44))),
                  ),
                  child: const Text(
                    "清空",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_user_name == "" ||
                        _user_phone == "" ||
                        _user_address == "" ||
                        _province_city_area == "省市区") {
                      showCustomToast("请输入姓名，手机号，省市区，详细地址等内容", 1500);
                    } else {
                      BoostNavigator.instance.pop({
                        "type": widget.argument['type'],
                        "name": _user_name,
                        "phone": _user_phone,
                        "address": _user_address,
                        "province_city_area": _province_city_area
                      });
                    }
                  },
                  style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(const Color(0xFFFAB000)),

                    textStyle: MaterialStateProperty.all(
                        TextStyle(fontSize: ScreenUtil().setSp(20))),

                    foregroundColor: MaterialStateProperty.resolveWith(
                      (states) {
                        if (states.contains(MaterialState.pressed)) {
                          ////按下时的颜色
                          return const Color(0xFF222222);
                        }
                        //默认状态使用灰色
                        return const Color(0xFF222222);
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

                    //设置按钮圆角
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(10)))),

                    //按钮大小
                    minimumSize: MaterialStateProperty.all(Size(
                        ScreenUtil().setWidth(278), ScreenUtil().setWidth(44))),
                  ),
                  child: const Text(
                    "确定",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _province_controller.dispose();
    _city_controller.dispose();
    _area_controller.dispose();
    super.dispose();
  }

  Future<bool?> _showSelectModalPopup() {
    resetPvovinceCityAreaData();
    return showCupertinoModalPopup<bool>(
      context: context,
      barrierDismissible: true, //点击遮罩时是否关闭
      builder: (context) {
        //要用StatefulBuilder，否则diaolog展示时不刷新
        return StatefulBuilder(builder: (context, flushModalPopup) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(16),
                          right: ScreenUtil().setWidth(16),
                          top: ScreenUtil().setWidth(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Text(
                              "取消",
                              style: TextStyle(
                                fontSize: ScreenUtil().setWidth(16),
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            onTap: () {
                              BoostNavigator.instance.pop(true);
                            },
                          ),
                          Text(
                            "选择省市区",
                            style: TextStyle(
                              fontSize: ScreenUtil().setWidth(18),
                              color: const Color(0xFF222222),
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              "确认",
                              style: TextStyle(
                                fontSize: ScreenUtil().setWidth(16),
                                color: const Color(0xFF222222),
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            onTap: () {
                              BoostNavigator.instance.pop(true);
                              setState(() {
                                _province_city_area =
                                    "${_province_data[_province_controller.selectedItem]['label']} ${_city_data[_city_controller.selectedItem]['label']} ${_area_data[_area_controller.selectedItem]['label']}";
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                      child: Container(
                        width: ScreenUtil().setWidth(390),
                        height: ScreenUtil().setWidth(0.5),
                        color: const Color(0xFFEEEEEE),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setWidth(18),
                          left: ScreenUtil().setWidth(16)),
                      child: Text(
                        "热门城市",
                        style: TextStyle(
                          fontSize: ScreenUtil().setWidth(14),
                          color: const Color(0xFF999999),
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setWidth(18),
                          left: ScreenUtil().setWidth(16),
                        ),
                        child: SizedBox(
                          width: ScreenUtil().setWidth(358),
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: hotCityData
                                .map((e) =>
                                    _updateHotCityWidget(e, flushModalPopup))
                                .toList(),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setWidth(20),
                          bottom: ScreenUtil().setWidth(20)),
                      child: SizedBox(
                        width: ScreenUtil().setWidth(390),
                        height: ScreenUtil().setWidth(210),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: NotificationListener(
                                onNotification: (Notification notification) {
                                  switch (notification.runtimeType) {
                                    case ScrollEndNotification:
                                      _onProvinceSelectedItemChanged(
                                          ((notification
                                                      as ScrollEndNotification)
                                                  .metrics as FixedExtentMetrics)
                                              .itemIndex);
                                      flushModalPopup(() {});
                                      break;
                                    default:
                                      break;
                                  }
                                  return true;
                                },
                                child: CupertinoPicker(
                                  itemExtent: ScreenUtil().setWidth(42),
                                  useMagnifier: true,
                                  selectionOverlay: _selectionOverlayWidget(),
                                  onSelectedItemChanged: (int index) {},
                                  scrollController: _province_controller,
                                  children: _province_data
                                      .map((data) =>
                                          _updateProvinceCityAreaDataWidget(
                                              data))
                                      .toList(),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: NotificationListener(
                                  onNotification: (Notification notification) {
                                    switch (notification.runtimeType) {
                                      case ScrollEndNotification:
                                        _onCitySelectedItemChanged(((notification
                                                    as ScrollEndNotification)
                                                .metrics as FixedExtentMetrics)
                                            .itemIndex);
                                        flushModalPopup(() {});
                                        break;
                                      default:
                                        break;
                                    }
                                    return true;
                                  },
                                  child: CupertinoPicker(
                                    useMagnifier: true,
                                    scrollController: _city_controller,
                                    selectionOverlay: _selectionOverlayWidget(),
                                    itemExtent: ScreenUtil().setWidth(42),
                                    onSelectedItemChanged: (int index) {},
                                    children: _city_data
                                        .map((data) =>
                                            _updateProvinceCityAreaDataWidget(
                                                data))
                                        .toList(),
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: NotificationListener(
                                  onNotification: (Notification notification) {
                                    switch (notification.runtimeType) {
                                      case ScrollEndNotification:
                                        _onAreaSelectedItemChanged(((notification
                                                    as ScrollEndNotification)
                                                .metrics as FixedExtentMetrics)
                                            .itemIndex);
                                        break;
                                      default:
                                        break;
                                    }
                                    return true;
                                  },
                                  child: CupertinoPicker(
                                    useMagnifier: true,
                                    scrollController: _area_controller,
                                    selectionOverlay: _selectionOverlayWidget(),
                                    itemExtent: ScreenUtil().setWidth(42),
                                    onSelectedItemChanged: (int index) {},
                                    children: _area_data
                                        .map((data) =>
                                            _updateProvinceCityAreaDataWidget(
                                                data))
                                        .toList(),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
      },
    );
  }

  Widget _updateProvinceCityAreaDataWidget(Map<String, String> data) {
    return Center(
      child: Text(
        data['label'].toString(),
        style: TextStyle(
            fontSize: ScreenUtil().setWidth(18),
            color: const Color(0xFF222222),
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _updateHotCityWidget(
      Map<String, Object> data, StateSetter flushModalPopup) {
    return OutlinedButton(
        onPressed: () {
          _province_controller.jumpToItem(data['province_index'] as int);
          _city_controller.jumpToItem(data['city_index'] as int);
          _area_controller.jumpToItem(data['area_index'] as int);
        },
        style: ButtonStyle(
          //设置文本不同状态时颜色
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
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            //设置按下时的背景颜色
            if (states.contains(MaterialState.pressed)) {
              return Colors.white;
            }
            //默认不使用背景颜色
            return Colors.white;
          }),

          //设置水波纹颜色
          overlayColor: MaterialStateProperty.all(const Color(0xFFF5F5F5)),

          //按钮大小
          minimumSize: MaterialStateProperty.all(
              Size(ScreenUtil().setWidth(80), ScreenUtil().setWidth(40))),
          //设置按钮圆角
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),

          //设置按钮边框颜色和宽度
          side: MaterialStateProperty.all(
              const BorderSide(color: Color(0xFFDDDDDD), width: 1)),
        ),
        child: Text(
          data['label'].toString(),
          style: TextStyle(
            fontSize: ScreenUtil().setWidth(16),
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none,
          ),
        ));
  }

  void resetPvovinceCityAreaData() {
    _province_index = 0;
    _city_index = 0;
    _province_data = provinceData;
    _city_data = cityData[_province_index];
    _area_data = areaData[_province_index][_city_index];
  }

  void _onProvinceSelectedItemChanged(int index) {
    print("_onProvinceSelectedItemChanged: $index");
    _province_index = index;
    _city_data = cityData[_province_index];
    _area_data = areaData[_province_index][0];
  }

  void _onCitySelectedItemChanged(int index) {
    print("_onCitySelectedItemChanged: $index");
    _city_index = index;
    _area_data = areaData[_province_index][_city_index];
  }

  void _onAreaSelectedItemChanged(int index) {
    print("_onCitySelectedItemChanged: $index");
  }

  // 弹出自定义Toast
  Future<bool?> showCustomToast(String toastContent, int millisecond) {
    Future.delayed(Duration(milliseconds: millisecond), () {
      BoostNavigator.instance.pop(true);
    });
    return showDialog<bool>(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false, //点击遮罩时是否关闭
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                    Radius.circular(ScreenUtil().setWidth(10))),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(20),
                    right: ScreenUtil().setWidth(20),
                    top: ScreenUtil().setWidth(10),
                    bottom: ScreenUtil().setWidth(10)),
                child: Text(toastContent,
                    style: TextStyle(
                        fontSize: ScreenUtil().setWidth(14),
                        color: const Color(0xFFFFFFFF),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        );
      },
    );
  }

  // 中间分割线
  Widget _selectionOverlayWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: Column(
        children: [
          const Divider(
            height: 1,
            color: Color(0xFFE5E5E5),
          ),
          Expanded(child: Container()),
          const Divider(
            height: 1,
            color: Color(0xFFE5E5E5),
          ),
        ],
      ),
    );
  }
}
