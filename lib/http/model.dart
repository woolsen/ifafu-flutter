import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ifafu/util/converter.dart';

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

@unfreezed
class User with _$User {
  factory User({
    required int id,
    required String nickname,
    required String avatarUrl,
    required List<String> permissions,
    required List<String> auths,
    String? username,
    int? qq,
    String? guildUserId,
    String? phone,
    String? gender,
    String? area,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

}

@unfreezed
class Post with _$Post {
  factory Post({
    required int id,
    required String area,
    required String content,
    required List<String>? images,
    required List<Comment>? comments,
    @DateTimeConverter() required DateTime createTime,
    required UserSmall createBy,
    required String? contact,
    required String? contactType,
    required int? viewCount,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

@freezed
class Comment with _$Comment {
  factory Comment({
    required int id,
    required String content,
    required UserSmall createBy,
    @DateTimeConverter() required DateTime createTime,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

@freezed
class UserSmall with _$UserSmall {
  factory UserSmall({
    required int id,
    required String nickname,
    required String? avatarUrl,
    required String? gender,
  }) = _UserSmall;

  factory UserSmall.fromJson(Map<String, dynamic> json) =>
      _$UserSmallFromJson(json);
}

@freezed
class PostCreate with _$PostCreate {
  factory PostCreate({
    required String area,
    required String content,
    required List<String> images,
    required String contact,
    required String? contactType,
  }) = _PostCreate;

  factory PostCreate.fromJson(Map<String, dynamic> json) => _$PostCreateFromJson(json);
}
