import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import '../data/bill_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpressTrack extends StatefulWidget {
  const ExpressTrack({super.key});

  @override
  State<StatefulWidget> createState() => _ExpressTrackState();
}

class _ExpressTrackState extends State<ExpressTrack> {
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
                "查件",
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
                  left: ScreenUtil().setWidth(12),
                  top: ScreenUtil().setWidth(12)),
              child: Container(
                width: ScreenUtil().setWidth(366),
                height: ScreenUtil().setWidth(140),
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
                                    image: AssetImage("images/signed.png"),
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
                            Expanded(
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(12),
                  top: ScreenUtil().setWidth(12),
                  bottom: ScreenUtil().setWidth(20)),
              child: Container(
                width: ScreenUtil().setWidth(366),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                  child: Column(
                    children: trackBillData
                        .map((e) => updateTrackDataWidget(e))
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //采用按行布局方式，缺点 最上面行难以对齐
  //派件状态 + 圆点 + 时间为一行，可以保证上面一行对齐
  Widget updateTrackDataWidget(Map<String, String> data) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(16), right: ScreenUtil().setWidth(16)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(data['orderStatusName'].toString(),
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: const Color(0xFF222222),
                        fontWeight: FontWeight.w500)),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      width: ScreenUtil().setWidth(16),
                      height: ScreenUtil().setWidth(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFABE00),
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(8)),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 15,
                child: Text(data['operateTime'].toString(),
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        color: const Color(0xFF999999),
                        fontWeight: FontWeight.w400)),
              ),
            ],
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                const Expanded(flex: 3, child: SizedBox()),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: ScreenUtil().setWidth(1),
                          color: const Color(0xFFEEEEEE),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    flex: 15,
                    child: Padding(
                      padding:
                          EdgeInsets.only(bottom: ScreenUtil().setWidth(30)),
                      child: Text(data['orderStatusDetails'].toString(),
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              color: const Color(0xFF222222),
                              fontWeight: FontWeight.w400)),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
