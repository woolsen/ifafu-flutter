// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Banner _$BannerFromJson(Map<String, dynamic> json) {
  return _Banner.fromJson(json);
}

/// @nodoc
mixin _$Banner {
  String? get title => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BannerCopyWith<Banner> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BannerCopyWith<$Res> {
  factory $BannerCopyWith(Banner value, $Res Function(Banner) then) =
      _$BannerCopyWithImpl<$Res, Banner>;
  @useResult
  $Res call({String? title, String imageUrl});
}

/// @nodoc
class _$BannerCopyWithImpl<$Res, $Val extends Banner>
    implements $BannerCopyWith<$Res> {
  _$BannerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BannerImplCopyWith<$Res> implements $BannerCopyWith<$Res> {
  factory _$$BannerImplCopyWith(
          _$BannerImpl value, $Res Function(_$BannerImpl) then) =
      __$$BannerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, String imageUrl});
}

/// @nodoc
class __$$BannerImplCopyWithImpl<$Res>
    extends _$BannerCopyWithImpl<$Res, _$BannerImpl>
    implements _$$BannerImplCopyWith<$Res> {
  __$$BannerImplCopyWithImpl(
      _$BannerImpl _value, $Res Function(_$BannerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? imageUrl = null,
  }) {
    return _then(_$BannerImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BannerImpl implements _Banner {
  _$BannerImpl({required this.title, required this.imageUrl});

  factory _$BannerImpl.fromJson(Map<String, dynamic> json) =>
      _$$BannerImplFromJson(json);

  @override
  final String? title;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'Banner(title: $title, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BannerImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BannerImplCopyWith<_$BannerImpl> get copyWith =>
      __$$BannerImplCopyWithImpl<_$BannerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BannerImplToJson(
      this,
    );
  }
}

abstract class _Banner implements Banner {
  factory _Banner(
      {required final String? title,
      required final String imageUrl}) = _$BannerImpl;

  factory _Banner.fromJson(Map<String, dynamic> json) = _$BannerImpl.fromJson;

  @override
  String? get title;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$BannerImplCopyWith<_$BannerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  int get id => throw _privateConstructorUsedError;
  set id(int value) => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  set nickname(String value) => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;
  set avatarUrl(String value) => throw _privateConstructorUsedError;
  List<String> get permissions => throw _privateConstructorUsedError;
  set permissions(List<String> value) => throw _privateConstructorUsedError;
  List<String> get auths => throw _privateConstructorUsedError;
  set auths(List<String> value) => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  set username(String? value) => throw _privateConstructorUsedError;
  int? get qq => throw _privateConstructorUsedError;
  set qq(int? value) => throw _privateConstructorUsedError;
  String? get guildUserId => throw _privateConstructorUsedError;
  set guildUserId(String? value) => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  set phone(String? value) => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  set gender(String? value) => throw _privateConstructorUsedError;
  String? get area => throw _privateConstructorUsedError;
  set area(String? value) => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;
  set isAdmin(bool value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {int id,
      String nickname,
      String avatarUrl,
      List<String> permissions,
      List<String> auths,
      String? username,
      int? qq,
      String? guildUserId,
      String? phone,
      String? gender,
      String? area,
      bool isAdmin});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = null,
    Object? avatarUrl = null,
    Object? permissions = null,
    Object? auths = null,
    Object? username = freezed,
    Object? qq = freezed,
    Object? guildUserId = freezed,
    Object? phone = freezed,
    Object? gender = freezed,
    Object? area = freezed,
    Object? isAdmin = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      auths: null == auths
          ? _value.auths
          : auths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      qq: freezed == qq
          ? _value.qq
          : qq // ignore: cast_nullable_to_non_nullable
              as int?,
      guildUserId: freezed == guildUserId
          ? _value.guildUserId
          : guildUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      area: freezed == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String?,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String nickname,
      String avatarUrl,
      List<String> permissions,
      List<String> auths,
      String? username,
      int? qq,
      String? guildUserId,
      String? phone,
      String? gender,
      String? area,
      bool isAdmin});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = null,
    Object? avatarUrl = null,
    Object? permissions = null,
    Object? auths = null,
    Object? username = freezed,
    Object? qq = freezed,
    Object? guildUserId = freezed,
    Object? phone = freezed,
    Object? gender = freezed,
    Object? area = freezed,
    Object? isAdmin = null,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      auths: null == auths
          ? _value.auths
          : auths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      qq: freezed == qq
          ? _value.qq
          : qq // ignore: cast_nullable_to_non_nullable
              as int?,
      guildUserId: freezed == guildUserId
          ? _value.guildUserId
          : guildUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      area: freezed == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String?,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  _$UserImpl(
      {required this.id,
      required this.nickname,
      required this.avatarUrl,
      required this.permissions,
      required this.auths,
      this.username,
      this.qq,
      this.guildUserId,
      this.phone,
      this.gender,
      this.area,
      this.isAdmin = false});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  int id;
  @override
  String nickname;
  @override
  String avatarUrl;
  @override
  List<String> permissions;
  @override
  List<String> auths;
  @override
  String? username;
  @override
  int? qq;
  @override
  String? guildUserId;
  @override
  String? phone;
  @override
  String? gender;
  @override
  String? area;
  @override
  @JsonKey()
  bool isAdmin;

  @override
  String toString() {
    return 'User(id: $id, nickname: $nickname, avatarUrl: $avatarUrl, permissions: $permissions, auths: $auths, username: $username, qq: $qq, guildUserId: $guildUserId, phone: $phone, gender: $gender, area: $area, isAdmin: $isAdmin)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  factory _User(
      {required int id,
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
      bool isAdmin}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  int get id;
  set id(int value);
  @override
  String get nickname;
  set nickname(String value);
  @override
  String get avatarUrl;
  set avatarUrl(String value);
  @override
  List<String> get permissions;
  set permissions(List<String> value);
  @override
  List<String> get auths;
  set auths(List<String> value);
  @override
  String? get username;
  set username(String? value);
  @override
  int? get qq;
  set qq(int? value);
  @override
  String? get guildUserId;
  set guildUserId(String? value);
  @override
  String? get phone;
  set phone(String? value);
  @override
  String? get gender;
  set gender(String? value);
  @override
  String? get area;
  set area(String? value);
  @override
  bool get isAdmin;
  set isAdmin(bool value);
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  int get id => throw _privateConstructorUsedError;
  String get area => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<String>? get images => throw _privateConstructorUsedError;
  List<Comment>? get comments => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createTime => throw _privateConstructorUsedError;
  UserSmall get createBy => throw _privateConstructorUsedError;
  String? get contact => throw _privateConstructorUsedError;
  String? get contactType => throw _privateConstructorUsedError;
  int? get viewCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call(
      {int id,
      String area,
      String content,
      List<String>? images,
      List<Comment>? comments,
      @DateTimeConverter() DateTime createTime,
      UserSmall createBy,
      String? contact,
      String? contactType,
      int? viewCount});

  $UserSmallCopyWith<$Res> get createBy;
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? area = null,
    Object? content = null,
    Object? images = freezed,
    Object? comments = freezed,
    Object? createTime = null,
    Object? createBy = null,
    Object? contact = freezed,
    Object? contactType = freezed,
    Object? viewCount = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>?,
      createTime: null == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createBy: null == createBy
          ? _value.createBy
          : createBy // ignore: cast_nullable_to_non_nullable
              as UserSmall,
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String?,
      contactType: freezed == contactType
          ? _value.contactType
          : contactType // ignore: cast_nullable_to_non_nullable
              as String?,
      viewCount: freezed == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserSmallCopyWith<$Res> get createBy {
    return $UserSmallCopyWith<$Res>(_value.createBy, (value) {
      return _then(_value.copyWith(createBy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(
          _$PostImpl value, $Res Function(_$PostImpl) then) =
      __$$PostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String area,
      String content,
      List<String>? images,
      List<Comment>? comments,
      @DateTimeConverter() DateTime createTime,
      UserSmall createBy,
      String? contact,
      String? contactType,
      int? viewCount});

  @override
  $UserSmallCopyWith<$Res> get createBy;
}

/// @nodoc
class __$$PostImplCopyWithImpl<$Res>
    extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? area = null,
    Object? content = null,
    Object? images = freezed,
    Object? comments = freezed,
    Object? createTime = null,
    Object? createBy = null,
    Object? contact = freezed,
    Object? contactType = freezed,
    Object? viewCount = freezed,
  }) {
    return _then(_$PostImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      comments: freezed == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>?,
      createTime: null == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createBy: null == createBy
          ? _value.createBy
          : createBy // ignore: cast_nullable_to_non_nullable
              as UserSmall,
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String?,
      contactType: freezed == contactType
          ? _value.contactType
          : contactType // ignore: cast_nullable_to_non_nullable
              as String?,
      viewCount: freezed == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostImpl implements _Post {
  _$PostImpl(
      {required this.id,
      required this.area,
      required this.content,
      required final List<String>? images,
      required final List<Comment>? comments,
      @DateTimeConverter() required this.createTime,
      required this.createBy,
      required this.contact,
      required this.contactType,
      required this.viewCount})
      : _images = images,
        _comments = comments;

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  @override
  final int id;
  @override
  final String area;
  @override
  final String content;
  final List<String>? _images;
  @override
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Comment>? _comments;
  @override
  List<Comment>? get comments {
    final value = _comments;
    if (value == null) return null;
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @DateTimeConverter()
  final DateTime createTime;
  @override
  final UserSmall createBy;
  @override
  final String? contact;
  @override
  final String? contactType;
  @override
  final int? viewCount;

  @override
  String toString() {
    return 'Post(id: $id, area: $area, content: $content, images: $images, comments: $comments, createTime: $createTime, createBy: $createBy, contact: $contact, contactType: $contactType, viewCount: $viewCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            (identical(other.createTime, createTime) ||
                other.createTime == createTime) &&
            (identical(other.createBy, createBy) ||
                other.createBy == createBy) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.contactType, contactType) ||
                other.contactType == contactType) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      area,
      content,
      const DeepCollectionEquality().hash(_images),
      const DeepCollectionEquality().hash(_comments),
      createTime,
      createBy,
      contact,
      contactType,
      viewCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImplToJson(
      this,
    );
  }
}

abstract class _Post implements Post {
  factory _Post(
      {required final int id,
      required final String area,
      required final String content,
      required final List<String>? images,
      required final List<Comment>? comments,
      @DateTimeConverter() required final DateTime createTime,
      required final UserSmall createBy,
      required final String? contact,
      required final String? contactType,
      required final int? viewCount}) = _$PostImpl;

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  @override
  int get id;
  @override
  String get area;
  @override
  String get content;
  @override
  List<String>? get images;
  @override
  List<Comment>? get comments;
  @override
  @DateTimeConverter()
  DateTime get createTime;
  @override
  UserSmall get createBy;
  @override
  String? get contact;
  @override
  String? get contactType;
  @override
  int? get viewCount;
  @override
  @JsonKey(ignore: true)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
mixin _$Comment {
  int get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  UserSmall get createBy => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res, Comment>;
  @useResult
  $Res call(
      {int id,
      String content,
      UserSmall createBy,
      @DateTimeConverter() DateTime createTime});

  $UserSmallCopyWith<$Res> get createBy;
}

/// @nodoc
class _$CommentCopyWithImpl<$Res, $Val extends Comment>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? createBy = null,
    Object? createTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createBy: null == createBy
          ? _value.createBy
          : createBy // ignore: cast_nullable_to_non_nullable
              as UserSmall,
      createTime: null == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserSmallCopyWith<$Res> get createBy {
    return $UserSmallCopyWith<$Res>(_value.createBy, (value) {
      return _then(_value.copyWith(createBy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommentImplCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$CommentImplCopyWith(
          _$CommentImpl value, $Res Function(_$CommentImpl) then) =
      __$$CommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String content,
      UserSmall createBy,
      @DateTimeConverter() DateTime createTime});

  @override
  $UserSmallCopyWith<$Res> get createBy;
}

/// @nodoc
class __$$CommentImplCopyWithImpl<$Res>
    extends _$CommentCopyWithImpl<$Res, _$CommentImpl>
    implements _$$CommentImplCopyWith<$Res> {
  __$$CommentImplCopyWithImpl(
      _$CommentImpl _value, $Res Function(_$CommentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? createBy = null,
    Object? createTime = null,
  }) {
    return _then(_$CommentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createBy: null == createBy
          ? _value.createBy
          : createBy // ignore: cast_nullable_to_non_nullable
              as UserSmall,
      createTime: null == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentImpl implements _Comment {
  _$CommentImpl(
      {required this.id,
      required this.content,
      required this.createBy,
      @DateTimeConverter() required this.createTime});

  factory _$CommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentImplFromJson(json);

  @override
  final int id;
  @override
  final String content;
  @override
  final UserSmall createBy;
  @override
  @DateTimeConverter()
  final DateTime createTime;

  @override
  String toString() {
    return 'Comment(id: $id, content: $content, createBy: $createBy, createTime: $createTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createBy, createBy) ||
                other.createBy == createBy) &&
            (identical(other.createTime, createTime) ||
                other.createTime == createTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, content, createBy, createTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      __$$CommentImplCopyWithImpl<_$CommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentImplToJson(
      this,
    );
  }
}

abstract class _Comment implements Comment {
  factory _Comment(
      {required final int id,
      required final String content,
      required final UserSmall createBy,
      @DateTimeConverter() required final DateTime createTime}) = _$CommentImpl;

  factory _Comment.fromJson(Map<String, dynamic> json) = _$CommentImpl.fromJson;

  @override
  int get id;
  @override
  String get content;
  @override
  UserSmall get createBy;
  @override
  @DateTimeConverter()
  DateTime get createTime;
  @override
  @JsonKey(ignore: true)
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSmall _$UserSmallFromJson(Map<String, dynamic> json) {
  return _UserSmall.fromJson(json);
}

/// @nodoc
mixin _$UserSmall {
  int get id => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserSmallCopyWith<UserSmall> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSmallCopyWith<$Res> {
  factory $UserSmallCopyWith(UserSmall value, $Res Function(UserSmall) then) =
      _$UserSmallCopyWithImpl<$Res, UserSmall>;
  @useResult
  $Res call({int id, String nickname, String? avatarUrl, String? gender});
}

/// @nodoc
class _$UserSmallCopyWithImpl<$Res, $Val extends UserSmall>
    implements $UserSmallCopyWith<$Res> {
  _$UserSmallCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = null,
    Object? avatarUrl = freezed,
    Object? gender = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserSmallImplCopyWith<$Res>
    implements $UserSmallCopyWith<$Res> {
  factory _$$UserSmallImplCopyWith(
          _$UserSmallImpl value, $Res Function(_$UserSmallImpl) then) =
      __$$UserSmallImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String nickname, String? avatarUrl, String? gender});
}

/// @nodoc
class __$$UserSmallImplCopyWithImpl<$Res>
    extends _$UserSmallCopyWithImpl<$Res, _$UserSmallImpl>
    implements _$$UserSmallImplCopyWith<$Res> {
  __$$UserSmallImplCopyWithImpl(
      _$UserSmallImpl _value, $Res Function(_$UserSmallImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = null,
    Object? avatarUrl = freezed,
    Object? gender = freezed,
  }) {
    return _then(_$UserSmallImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSmallImpl implements _UserSmall {
  _$UserSmallImpl(
      {required this.id,
      required this.nickname,
      required this.avatarUrl,
      required this.gender});

  factory _$UserSmallImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSmallImplFromJson(json);

  @override
  final int id;
  @override
  final String nickname;
  @override
  final String? avatarUrl;
  @override
  final String? gender;

  @override
  String toString() {
    return 'UserSmall(id: $id, nickname: $nickname, avatarUrl: $avatarUrl, gender: $gender)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSmallImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.gender, gender) || other.gender == gender));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, nickname, avatarUrl, gender);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSmallImplCopyWith<_$UserSmallImpl> get copyWith =>
      __$$UserSmallImplCopyWithImpl<_$UserSmallImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSmallImplToJson(
      this,
    );
  }
}

abstract class _UserSmall implements UserSmall {
  factory _UserSmall(
      {required final int id,
      required final String nickname,
      required final String? avatarUrl,
      required final String? gender}) = _$UserSmallImpl;

  factory _UserSmall.fromJson(Map<String, dynamic> json) =
      _$UserSmallImpl.fromJson;

  @override
  int get id;
  @override
  String get nickname;
  @override
  String? get avatarUrl;
  @override
  String? get gender;
  @override
  @JsonKey(ignore: true)
  _$$UserSmallImplCopyWith<_$UserSmallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PostCreate _$PostCreateFromJson(Map<String, dynamic> json) {
  return _PostCreate.fromJson(json);
}

/// @nodoc
mixin _$PostCreate {
  String get area => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  String get contact => throw _privateConstructorUsedError;
  String? get contactType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCreateCopyWith<PostCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCreateCopyWith<$Res> {
  factory $PostCreateCopyWith(
          PostCreate value, $Res Function(PostCreate) then) =
      _$PostCreateCopyWithImpl<$Res, PostCreate>;
  @useResult
  $Res call(
      {String area,
      String content,
      List<String> images,
      String contact,
      String? contactType});
}

/// @nodoc
class _$PostCreateCopyWithImpl<$Res, $Val extends PostCreate>
    implements $PostCreateCopyWith<$Res> {
  _$PostCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = null,
    Object? content = null,
    Object? images = null,
    Object? contact = null,
    Object? contactType = freezed,
  }) {
    return _then(_value.copyWith(
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      contact: null == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String,
      contactType: freezed == contactType
          ? _value.contactType
          : contactType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostCreateImplCopyWith<$Res>
    implements $PostCreateCopyWith<$Res> {
  factory _$$PostCreateImplCopyWith(
          _$PostCreateImpl value, $Res Function(_$PostCreateImpl) then) =
      __$$PostCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String area,
      String content,
      List<String> images,
      String contact,
      String? contactType});
}

/// @nodoc
class __$$PostCreateImplCopyWithImpl<$Res>
    extends _$PostCreateCopyWithImpl<$Res, _$PostCreateImpl>
    implements _$$PostCreateImplCopyWith<$Res> {
  __$$PostCreateImplCopyWithImpl(
      _$PostCreateImpl _value, $Res Function(_$PostCreateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = null,
    Object? content = null,
    Object? images = null,
    Object? contact = null,
    Object? contactType = freezed,
  }) {
    return _then(_$PostCreateImpl(
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      contact: null == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String,
      contactType: freezed == contactType
          ? _value.contactType
          : contactType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostCreateImpl implements _PostCreate {
  _$PostCreateImpl(
      {required this.area,
      required this.content,
      required final List<String> images,
      required this.contact,
      required this.contactType})
      : _images = images;

  factory _$PostCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostCreateImplFromJson(json);

  @override
  final String area;
  @override
  final String content;
  final List<String> _images;
  @override
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final String contact;
  @override
  final String? contactType;

  @override
  String toString() {
    return 'PostCreate(area: $area, content: $content, images: $images, contact: $contact, contactType: $contactType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostCreateImpl &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.contactType, contactType) ||
                other.contactType == contactType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, area, content,
      const DeepCollectionEquality().hash(_images), contact, contactType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostCreateImplCopyWith<_$PostCreateImpl> get copyWith =>
      __$$PostCreateImplCopyWithImpl<_$PostCreateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostCreateImplToJson(
      this,
    );
  }
}

abstract class _PostCreate implements PostCreate {
  factory _PostCreate(
      {required final String area,
      required final String content,
      required final List<String> images,
      required final String contact,
      required final String? contactType}) = _$PostCreateImpl;

  factory _PostCreate.fromJson(Map<String, dynamic> json) =
      _$PostCreateImpl.fromJson;

  @override
  String get area;
  @override
  String get content;
  @override
  List<String> get images;
  @override
  String get contact;
  @override
  String? get contactType;
  @override
  @JsonKey(ignore: true)
  _$$PostCreateImplCopyWith<_$PostCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
