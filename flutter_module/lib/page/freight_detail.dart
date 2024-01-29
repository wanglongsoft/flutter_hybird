import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FreightDetail extends StatefulWidget {
  final Map argument;
  const FreightDetail({required this.argument, super.key});

  @override
  State<FreightDetail> createState() => _FreightDetailState();
}

class _FreightDetailState extends State<FreightDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

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
              child: const Text(
                "费用明细",
                style: TextStyle(color: Color(0xFF000000)),
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
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(12),
                top: ScreenUtil().setWidth(12)),
            child: Container(
              width: ScreenUtil().setWidth(366),
              height: ScreenUtil().setWidth(330),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
              ),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(16),
                          top: ScreenUtil().setWidth(16)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "运单号 ",
                            style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.w200),
                          ),
                          Text("160085313807511234",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF222222),
                                  fontWeight: FontWeight.w400)),
                          Image(
                            image: AssetImage("images/copy.png"),
                            width: 16.0,
                            height: 16.0,
                          )
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(28)),
                    child: SizedBox(
                      width: ScreenUtil().setWidth(280),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Expanded(
                            flex: 1,
                            child: Center(
                                child: Text("上海市",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF222222),
                                        fontWeight: FontWeight.w500))),
                          ),
                          Expanded(
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
                              child: Text("上海市",
                                  style: TextStyle(
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
                        children: const [
                          Expanded(
                            flex: 1,
                            child: Center(
                                child: Text("王栅子",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF999999),
                                        fontWeight: FontWeight.w400))),
                          ),
                          Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text("李庄店",
                                  style: TextStyle(
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
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(28)),
                    child: Container(
                      width: ScreenUtil().setWidth(334),
                      height: ScreenUtil().setWidth(1),
                      color: const Color(0xFFEEEEEE),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(20),
                      left: ScreenUtil().setWidth(16),
                      right: ScreenUtil().setWidth(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("快递类型",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w400)),
                        Text("特惠寄",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                color: const Color(0xFF222222),
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(20),
                      left: ScreenUtil().setWidth(16),
                      right: ScreenUtil().setWidth(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("基础运费",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w400)),
                        Text("¥14.00",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                color: const Color(0xFF222222),
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(20),
                      left: ScreenUtil().setWidth(32),
                      right: ScreenUtil().setWidth(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("首重费（1KG以内）",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w400)),
                        Text("¥10.00",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                color: const Color(0xFF222222),
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(20),
                      left: ScreenUtil().setWidth(32),
                      right: ScreenUtil().setWidth(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("续重费（不足1KG按1KG计算）",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w400)),
                        Text("¥4.00",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                color: const Color(0xFF222222),
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(12),
                top: ScreenUtil().setWidth(12)),
            child: Container(
              width: ScreenUtil().setWidth(366),
              height: ScreenUtil().setWidth(108),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(16),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("优惠信息",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(16),
                              color: const Color(0xFF222222),
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(334),
                    height: ScreenUtil().setWidth(1),
                    color: const Color(0xFFEEEEEE),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(16),
                      right: ScreenUtil().setWidth(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("折扣减免",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(16),
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w400)),
                        Text("-¥2.80",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(16),
                                color: const Color(0xFFE34444),
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(12),
                top: ScreenUtil().setWidth(12)),
            child: Container(
              width: ScreenUtil().setWidth(366),
              height: ScreenUtil().setWidth(40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
              ),
              alignment: Alignment.center,
              child: const Text.rich(TextSpan(
                children: [
                  TextSpan(
                      text: "待支付总费用  ",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF999999),
                          fontWeight: FontWeight.w400)),
                  TextSpan(
                      text: "￥11.20",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFE34444),
                          fontWeight: FontWeight.w400)),
                ]
              )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(16)),
            child: OutlinedButton(
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

                ///按钮背景颜色
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  //设置按下时的背景颜色
                  if (states.contains(MaterialState.pressed)) {
                    return const Color(0xFFFABE00);
                  }
                  //默认不使用背景颜色
                  return const Color(0xFFFABE00);
                }),

                overlayColor: MaterialStateProperty.all(Colors.yellow.shade800),

                ///设置按钮圆角
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(20)))),

                ///按钮大小
                minimumSize: MaterialStateProperty.all(Size(
                    ScreenUtil().setWidth(366), ScreenUtil().setWidth(40))),
              ),
              onPressed: () {},
              child: Text("立即支付",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
