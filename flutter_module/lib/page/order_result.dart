import 'package:flutter/material.dart';
import 'package:flutter_module/util/common_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderResult extends StatefulWidget {
  final Map argument;
  const OrderResult({super.key, required this.argument});

  @override
  State<OrderResult> createState() => _OrderResultState();
}

class _OrderResultState extends State<OrderResult> {
  @override
  Widget build(BuildContext context) {
    //屏幕适配初始化
    ScreenUtil.init(context, designSize: const Size(390, 844));
    return Scaffold(
        appBar: getCommonAppBar(context, widget.argument['title']),
        body: widget.argument['type'] == 'success'
            ? getOrderSuccessWidget()
            : getOrderFailWidget(widget.argument['reason']));
  }

  Widget getOrderSuccessWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setWidth(76), left: ScreenUtil().setWidth(18)),
          child: Image(
            image: const AssetImage("images/order_success.png"),
            fit: BoxFit.fitWidth,
            width: ScreenUtil().setWidth(108),
            height: ScreenUtil().setWidth(108),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(32)),
          child: Text("下单成功",
              style: TextStyle(
                color: const Color(0xFF222222),
                fontSize: ScreenUtil().setSp(24),
                fontWeight: FontWeight.w500,
              )),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setWidth(20),
              left: ScreenUtil().setWidth(36),
              right: ScreenUtil().setWidth(36)),
          child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(children: [
                TextSpan(
                    text: "快递员将在",
                    style: TextStyle(
                      color: const Color(0xFF999999),
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w400,
                    )),
                TextSpan(
                    text: "明天19:00前",
                    style: TextStyle(
                      color: const Color(0xFFE34444),
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w400,
                    )),
                TextSpan(
                    text: "与您联系上门取件，请保持联系方式通畅。",
                    style: TextStyle(
                      color: const Color(0xFF999999),
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w400,
                    )),
              ])),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(40)),
          child: Container(
              width: ScreenUtil().setWidth(180),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(16))),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(16)),
                    child: Text("取件码",
                        style: TextStyle(
                          color: const Color(0xFF222222),
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(16)),
                      child: Divider(
                        color: const Color(0xFFBBBBBB),
                        height: ScreenUtil().setWidth(1),
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setWidth(20),
                        bottom: ScreenUtil().setWidth(20)),
                    child: Text("6460",
                        style: TextStyle(
                          color: const Color(0xFF222222),
                          fontSize: ScreenUtil().setSp(36),
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget getOrderFailWidget(String reason) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: ScreenUtil()
                .setWidth(390)), //撑起页面宽度，否则Column的CrossAxisAlignment.center不生效
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setWidth(76), left: ScreenUtil().setWidth(18)),
          child: Image(
            image: const AssetImage("images/order_fail.png"),
            fit: BoxFit.fitWidth,
            width: ScreenUtil().setWidth(108),
            height: ScreenUtil().setWidth(108),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(32)),
          child: Text("下单失败",
              style: TextStyle(
                color: const Color(0xFF222222),
                fontSize: ScreenUtil().setSp(24),
                fontWeight: FontWeight.w500,
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
          child: Text("下单失败，可重新进件。",
              style: TextStyle(
                color: const Color(0xFF999999),
                fontSize: ScreenUtil().setSp(14),
                fontWeight: FontWeight.w400,
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(40)),
          child: Text("失败原因",
              style: TextStyle(
                color: const Color(0xFF222222),
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.w500,
              )),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setWidth(16),
              left: ScreenUtil().setWidth(36),
              right: ScreenUtil().setWidth(36)),
          child: Text(reason,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF999999),
                fontSize: ScreenUtil().setSp(14),
                fontWeight: FontWeight.w400,
              )),
        ),
      ],
    );
  }
}
