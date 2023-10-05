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
      isBindJw: json['isBindJw'] as bool? ?? false,
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
      'isBindJw': instance.isBindJw,
      'username': instance.username,
      'qq': instance.qq,
      'guildUserId': instance.guildUserId,
      'phone': instance.phone,
      'gender': instance.gender,
      'area': instance.area,
    };

_$UserUpdateImpl _$$UserUpdateImplFromJson(Map<String, dynamic> json) =>
    _$UserUpdateImpl(
      nickname: json['nickname'] as String,
      avatarUrl: json['avatarUrl'] as String,
      area: json['area'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$$UserUpdateImplToJson(_$UserUpdateImpl instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'area': instance.area,
      'gender': instance.gender,
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

_$PostCreateImpl _$$PostCreateImplFromJson(Map<String, dynamic> json) =>
    _$PostCreateImpl(
      area: json['area'] as String,
      content: json['content'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      contact: json['contact'] as String,
      contactType: json['contactType'] as String?,
    );

Map<String, dynamic> _$$PostCreateImplToJson(_$PostCreateImpl instance) =>
    <String, dynamic>{
      'area': instance.area,
      'content': instance.content,
      'images': instance.images,
      'contact': instance.contact,
      'contactType': instance.contactType,
    };

_$PersonalTimetableImpl _$$PersonalTimetableImplFromJson(
        Map<String, dynamic> json) =>
    _$PersonalTimetableImpl(
      year: json['year'] as String,
      semester: json['semester'] as int,
      openDay: const DateTimeConverter().fromJson(json['openDay'] as String),
      courses: (json['courses'] as List<dynamic>)
          .map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PersonalTimetableImplToJson(
        _$PersonalTimetableImpl instance) =>
    <String, dynamic>{
      'year': instance.year,
      'semester': instance.semester,
      'openDay': const DateTimeConverter().toJson(instance.openDay),
      'courses': instance.courses,
    };

_$CourseImpl _$$CourseImplFromJson(Map<String, dynamic> json) => _$CourseImpl(
      id: json['id'] as int?,
      name: json['name'] as String,
      teacher: json['teacher'] as String,
      location: json['location'] as String,
      weeks: (json['weeks'] as List<dynamic>).map((e) => e as int).toSet(),
      weekday: json['weekday'] as int,
      startNode: json['startNode'] as int,
      nodeCount: json['nodeCount'] as int,
    );

Map<String, dynamic> _$$CourseImplToJson(_$CourseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'teacher': instance.teacher,
      'location': instance.location,
      'weeks': instance.weeks.toList(),
      'weekday': instance.weekday,
      'startNode': instance.startNode,
      'nodeCount': instance.nodeCount,
    };

_$TermImpl _$$TermImplFromJson(Map<String, dynamic> json) => _$TermImpl(
      year: json['year'] as String,
      term: json['term'] as String,
    );

Map<String, dynamic> _$$TermImplToJson(_$TermImpl instance) =>
    <String, dynamic>{
      'year': instance.year,
      'term': instance.term,
    };

_$TimetableSetImpl _$$TimetableSetImplFromJson(Map<String, dynamic> json) =>
    _$TimetableSetImpl(
      timeIndex: json['timeIndex'] as int? ?? null,
      showTime: json['showTime'] as bool? ?? true,
      backgroundPath: json['backgroundPath'] as String?,
    );

Map<String, dynamic> _$$TimetableSetImplToJson(_$TimetableSetImpl instance) =>
    <String, dynamic>{
      'timeIndex': instance.timeIndex,
      'showTime': instance.showTime,
      'backgroundPath': instance.backgroundPath,
    };

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      type: json['type'] as String,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
    };

_$MajorTimetableImpl _$$MajorTimetableImplFromJson(Map<String, dynamic> json) =>
    _$MajorTimetableImpl(
      major: json['major'] as String,
      grade: json['grade'] as String,
      clazz: json['clazz'] as String,
      updateTime:
          const DateTimeConverter().fromJson(json['updateTime'] as String),
      courses: (json['courses'] as List<dynamic>)
          .map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MajorTimetableImplToJson(
        _$MajorTimetableImpl instance) =>
    <String, dynamic>{
      'major': instance.major,
      'grade': instance.grade,
      'clazz': instance.clazz,
      'updateTime': const DateTimeConverter().toJson(instance.updateTime),
      'courses': instance.courses,
    };
