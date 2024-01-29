import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar getCommonAppBar(context, title) {
  return  AppBar(
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
            title,
            style: const TextStyle(color: Color(0xFF000000)),
          ),
        ),
      ),
      SizedBox(
        width: ScreenUtil().setWidth(78),
      ),
    ],
  );
}