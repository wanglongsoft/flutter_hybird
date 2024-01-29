import 'package:dio/dio.dart';

class DioUtil {
  /// 单例模式
  static DioUtil? _instance;

  late Dio _dio;

  /// 连接超时时间
  static const int connectTimeout = 10 * 1000;
  /// 响应超时时间
  static const int receiveTimeout = 10 * 1000;

  factory DioUtil() => _instance ?? DioUtil._internal();
  static DioUtil? get instance => _instance ?? DioUtil._internal();

  DioUtil._internal() {
    _instance = this;

    Map<String, dynamic> httpHeaders = {
      'Content-Type': 'application/json',
    };

    // 初始化基本选项
    BaseOptions options = BaseOptions(
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        baseUrl: "https://pay-uat.yundasys.com/gateway/interface",
        headers: httpHeaders
    );
    _instance = this;
    // 初始化dio
    _dio = Dio(options);
    // 添加拦截器
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: _onRequest, onResponse: _onResponse, onError: _onError));
  }

  /// 请求拦截器
  void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options可以根据业务添加需求，如
    // options.headers["token"] = "xxx";
    // 更多业务需求
    handler.next(options);
  }

  /// 相应拦截器
  void _onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // 请求成功是对数据做基本处理
    // if (response.statusCode == 200) {
    //   // ....
    // } else {
    //   // ....
    // }
    // if (response.requestOptions.baseUrl.contains("???????")) {
    //   // 对某些单独的url返回数据做特殊处理
    // }
    handler.next(response);
  }

  /// 错误处理
  void _onError(DioError exception, ErrorInterceptorHandler handler) {
    handler.next(exception);
  }

  /// 请求类
  Future<T> postRequest<T>({
        Map<String, dynamic>? params,
        Object? data,
        CancelToken? cancelToken,
        Options? options,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    options ??= Options(method: 'post');
    try {
      Response response;
      response = await _dio.post("",
          data: data,
          queryParameters: params,
          cancelToken: cancelToken,
          options: options,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } on Exception {
      rethrow;
    }
  }

  /// 开启日志打印
  /// 需要打印日志的接口在接口请求前 DioUtil.instance?.openLog();
  void openLog() {
    _dio.interceptors
        .add(LogInterceptor(responseHeader: false, responseBody: true));
  }
}