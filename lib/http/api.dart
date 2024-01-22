import 'package:dio/dio.dart';
import 'package:ifafu/http/interceptor.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/util/sp.dart';

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
      // ..interceptors.add(PrettyDioLogger(
      //     requestHeader: true,
      //     requestBody: false,
      //     responseBody: true,
      //     responseHeader: false,
      //     error: true,
      //     maxWidth: 90))
      ..interceptors.add(DioInterceptor())
      ..interceptors.add(_tokenInterceptor);
  }

  Future<List<Banner>> getBanners([String? area]) async {
    final queryParameters = <String, String>{};
    if (area != null) {
      queryParameters['area'] = area;
    }
    var response = await dio.get(
      '/api/banner',
      queryParameters: queryParameters,
    );
    return (response.data as List).map((e) => Banner.fromJson(e)).toList();
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
    var response = await dio.get('/api/auth/info');
    return User.fromJson(response.data);
  }

  Future<User> editProfile(UserUpdate user) async {
    var response = await dio.put('/api/users/center', data: user.toJson());
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
        .map((e) => Post.fromJson(e))
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
        .map((e) => Post.fromJson(e))
        .toList();
  }

  Future<Post> createPost(PostCreate post) async {
    var response = await dio.post(
      '/api/post',
      data: post.toJson(),
    );
    return Post.fromJson(response.data);
  }

  Future<Post> commentPost(int postId, String content) async {
    var response = await dio.post(
      '/api/post/comment',
      data: {
        'postId': postId,
        'content': content,
      },
    );
    return Post.fromJson(response.data);
  }

  Future<void> deleteComment(int commentId) async {
    await dio.delete(
      '/api/post/comment',
      queryParameters: {
        'id': commentId,
      },
    );
  }

  Future<void> deletePost(int postId) async {
    await dio.delete(
      '/api/post',
      queryParameters: {
        'id': postId,
      },
    );
  }

  //上传图片
  Future<String> uploadPostImage(MultipartFile image) async {
    var response = await dio.post(
      '/api/post/picture',
      data: FormData.fromMap({
        'file': image,
      }),
    );
    return response.data;
  }

  Future<PersonalTimetable> getPersonalTimetable() async {
    var response = await dio.get('/api/jw/timetable/personal');
    return PersonalTimetable.fromJson(response.data);
  }

  Future<ScoreTable> getScores() async {
    var response = await dio.get('/api/jw/score');
    return ScoreTable.fromJson(response.data);
  }

  Future<ScoreTable> refreshScores() async {
    var response = await dio.get('/api/jw/score/refresh');
    return ScoreTable.fromJson(response.data);
  }

  Future<PersonalTimetable> refreshPersonalTimetable() async {
    var response = await dio.get('/api/jw/timetable/personal/refresh');
    return PersonalTimetable.fromJson(response.data);
  }

  Future<void> bindJw(String sno, String password) async {
    await dio.post(
      '/api/jw/user/bind',
      data: {
        'sno': sno,
        'password': password,
      },
    );
  }

  Future<void> unbindJw() async {
    await dio.post('/api/jw/user/unbind');
  }

  Future<List<Message>> queryQaAnswer(String message) async {
    var response = await dio.post(
      '/api/qa/answer',
      data: {
        'message': message,
        'type': 'array',
        'library': ['FAFU'],
      },
    );
    return (response.data as List).map((e) => Message.fromJson(e)).toList();
  }

  Future<Map<String, List<String>>> queryQaLibrary() async {
    var response = await dio.post(
      '/api/qa/library/question',
      data: ['FAFU'],
      options: Options(
        contentType: 'application/json',
      ),
    );
    return (response.data as Map<String, dynamic>).map((key, value) {
      return MapEntry(key, (value as List).map((e) => e as String).toList());
    });
  }

  Future<MajorTimetableOptions> getMajorTimetableOptions() async {
    var response = await dio.get('/api/jw/timetable/options2');
    return (response.data as Map<String, dynamic>).map((key, value) {
      return MapEntry(
        key,
        (value as Map<String, dynamic>).map((key, value) {
          return MapEntry(
            key,
            (value as Map<String, dynamic>).map((key, value) {
              return MapEntry(key, value as int);
            }),
          );
        }),
      );
    });
  }

  Future<MajorTimetable> getMajorTimetable(int id) async {
    var response = await dio.get(
      '/api/jw/timetable/id/$id',
    );
    return MajorTimetable.fromJson(response.data);
  }

  Future<AppUpdate> checkUpdate({
    required String platform,
    required String channel,
  }) async {
    var response = await dio.get(
      '/api/app/update/latest',
      queryParameters: {
        'platform': platform,
        'channel': channel,
      },
    );
    return AppUpdate.fromJson(response.data);
  }

  Future<void> downloadOnce() async {
    await dio.get(
      '/api/app/download/once',
    );
  }
}
