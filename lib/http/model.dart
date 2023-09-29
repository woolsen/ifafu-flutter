import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

part 'model.g.dart';

@freezed
class Banner with _$Banner {
  factory Banner({
    required String? title,
    required String imageUrl,
  }) = _Banner;

  factory Banner.fromJson(Map<String, Object?> json) => _$BannerFromJson(json);
}

@freezed
class User with _$User {
  factory User({
    required int id,
    required String nickname,
    required String avatarUrl,
    required List<String> permissions,
    required List<String> auths,
    required String? username,
    required int? qq,
    required String? guildUserId,
    required String? phone,
    required String? gender,
    required String? area,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Post with _$Post {
  factory Post({
    required int id,
    required String area,
    required String content,
    required List<String> images,
    required List<Comment> comments,
    required String createTime,
    required UserSmall createBy,
    String? contact,
    String? contactType,
    int? viewCount,
    String? updateTime,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

@freezed
class Comment with _$Comment {
  factory Comment({
    required int id,
    required String content,
    required UserSmall createBy,
    required String createTime,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

@freezed
class UserSmall with _$UserSmall {
  factory UserSmall({
    required int id,
    required String nickname,
    required String avatarUrl,
    String? gender,
  }) = _UserSmall;

  factory UserSmall.fromJson(Map<String, dynamic> json) =>
      _$UserSmallFromJson(json);
}
