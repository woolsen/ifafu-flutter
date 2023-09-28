// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BannerImpl _$$BannerImplFromJson(Map<String, dynamic> json) => _$BannerImpl(
      title: json['title'] as String?,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$BannerImplToJson(_$BannerImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'imageUrl': instance.imageUrl,
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as int,
      nickname: json['nickname'] as String,
      avatarUrl: json['avatarUrl'] as String,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      auths: (json['auths'] as List<dynamic>).map((e) => e as String).toList(),
      username: json['username'] as String?,
      qq: json['qq'] as int?,
      guildUserId: json['guildUserId'] as String?,
      phone: json['phone'] as String?,
      gender: json['gender'] as String?,
      area: json['area'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'permissions': instance.permissions,
      'auths': instance.auths,
      'username': instance.username,
      'qq': instance.qq,
      'guildUserId': instance.guildUserId,
      'phone': instance.phone,
      'gender': instance.gender,
      'area': instance.area,
    };

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      id: json['id'] as int,
      area: json['area'] as String,
      content: json['content'] as String,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      createTime:
          const DateTimeConverter().fromJson(json['createTime'] as String),
      createBy: UserSmall.fromJson(json['createBy'] as Map<String, dynamic>),
      contact: json['contact'] as String?,
      contactType: json['contactType'] as String?,
      viewCount: json['viewCount'] as int?,
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'area': instance.area,
      'content': instance.content,
      'images': instance.images,
      'comments': instance.comments,
      'createTime': const DateTimeConverter().toJson(instance.createTime),
      'createBy': instance.createBy,
      'contact': instance.contact,
      'contactType': instance.contactType,
      'viewCount': instance.viewCount,
    };

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: json['id'] as int,
      content: json['content'] as String,
      createBy: UserSmall.fromJson(json['createBy'] as Map<String, dynamic>),
      createTime:
          const DateTimeConverter().fromJson(json['createTime'] as String),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'createBy': instance.createBy,
      'createTime': const DateTimeConverter().toJson(instance.createTime),
    };

_$UserSmallImpl _$$UserSmallImplFromJson(Map<String, dynamic> json) =>
    _$UserSmallImpl(
      id: json['id'] as int,
      nickname: json['nickname'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$$UserSmallImplToJson(_$UserSmallImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'gender': instance.gender,
    };
