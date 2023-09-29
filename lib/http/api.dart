import 'package:dio/dio.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/http/interceptor.dart';

class Api {
  static final Api instance = Api._internal();

  factory Api() => instance;

  static late Dio dio;

  static const String baseUrl = 'https://api2.ifafu.cn';

  Api._internal() {
    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    dio = Dio(options)
      ..interceptors.add(PrettyDioLogger(
          requestHeader: false,
          requestBody: false,
          responseBody: false,
          responseHeader: false,
          error: true,
          maxWidth: 90))
      ..interceptors.add(DioInterceptor())
      ..interceptors.add(TokenInterceptor());
  }

  Future<List<Banner>> getBanners() async {
    var response = await dio.get('/api/banner');
    return (response.data as List)
        .map((e) => Banner.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> getSmsCode(String phone) async {
    await dio.get('/api/auth/code/sms', queryParameters: {'phone': phone});
  }
}
