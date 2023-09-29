import 'package:dio/dio.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/http/interceptor.dart';
import 'package:ifafu/util/sp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static final Api instance = Api._internal();

  factory Api() => instance;

  static late Dio dio;

  static const String baseUrl = 'https://api2.ifafu.cn';

  final _tokenInterceptor = TokenInterceptor();

  Api._internal() {
    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    dio = Dio(options)
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: false,
          responseBody: true,
          responseHeader: false,
          error: true,
          maxWidth: 90))
      ..interceptors.add(DioInterceptor())
      ..interceptors.add(_tokenInterceptor);
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

  Future<User> login(String phone, String code) async {
    var response = await dio
        .post('/api/auth/login/sms', data: {'phone': phone, 'code': code});
    String token = response.data['token'];
    _tokenInterceptor.token = token;
    SPUtil.setString('TOKEN', token);
    return User.fromJson(response.data['user']);
  }

  Future<void> logout() async {
    await dio.post('/api/auth/logout');
    _tokenInterceptor.token = null;
    SPUtil.remove('TOKEN');
  }

  Future<User> getUserInfo() async {
    var response = await dio.get('/api/user');
    return User.fromJson(response.data);
  }

  Future<List<Post>> getPosts(int page, int size, String area) async {
    var response = await dio.get(
      '/api/post',
      queryParameters: {
        'page': page,
        'size': size,
        'area': area,
      },
    );
    return (response.data['content'] as List)
        .map((e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Post>> getMyPosts(int page, int size) async {
    var response = await dio.get(
      '/api/post/me',
      queryParameters: {
        'page': page,
        'size': size,
      },
    );
    return (response.data['content'] as List)
        .map((e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<User> editProfile(User user) async {
    var response = await dio.put('/api/users/center', data: user.toJson());
    return User.fromJson(response.data);
  }
}
