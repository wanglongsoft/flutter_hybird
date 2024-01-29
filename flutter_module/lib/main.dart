import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'data/router_map.dart';

void main() async {
  CustomFlutterBinding();
  //添加全局生命周期监听类
  PageVisibilityBinding.instance.addGlobalObserver(AppLifecycleObserver());
  runApp(const MyApp());
}

class CustomFlutterBinding extends WidgetsFlutterBinding
    with BoostFlutterBinding {}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Route<dynamic>? routeFactory(RouteSettings settings, String? uniqueId) {
    FlutterBoostRouteFactory? func = routerMap[settings.name!];
    if (func == null) {
      return null;
    }
    return func(settings, uniqueId);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("MyApp build(BuildContext context)");
    return FlutterBoostApp(routeFactory, appBuilder: appBuilder);
  }

  Widget appBuilder(Widget home) {
    return MaterialApp(
      home: home,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF5F5F5), //修改页面的背景
          //修改AppBar的主体样式
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white, //修改AppBar的背景
              elevation: 0, //隐藏AppBar底部的阴影分割线
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent, //修改statusBar的背景颜色
                systemNavigationBarColor: Color(0xFFFFFFFF),
                systemNavigationBarIconBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark,
              ) //设置状态栏的背景
          ),
          visualDensity: VisualDensity.standard),
      builder: (_, __) {
        return home;
      },
      //添加这个，否则Bruno报错: type 'Null' is not a subtype of type 'BrnIntl'
      localizationsDelegates:  [
        BrnLocalizationDelegate.delegate,
      ],
    );
  }
}

///全局生命周期监听示例
class AppLifecycleObserver with GlobalPageVisibilityObserver {
  @override
  void onBackground(Route route) {
    super.onBackground(route);
    print("AppLifecycleObserver - onBackground");
  }

  @override
  void onForeground(Route route) {
    super.onForeground(route);
    print("AppLifecycleObserver - onForground");
  }

  @override
  void onPagePush(Route route) {
    super.onPagePush(route);
    print("AppLifecycleObserver - onPagePush");
  }

  @override
  void onPagePop(Route route) {
    super.onPagePop(route);
    print("AppLifecycleObserver - onPagePop");
  }

  @override
  void onPageHide(Route route) {
    super.onPageHide(route);
    print("AppLifecycleObserver - onPageHide");
  }

  @override
  void onPageShow(Route route) {
    super.onPageShow(route);
    print("AppLifecycleObserver - onPageShow");
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //修改statusBar的背景颜色
      systemNavigationBarColor: Color(0xFFFFFFFF),
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
  }
}