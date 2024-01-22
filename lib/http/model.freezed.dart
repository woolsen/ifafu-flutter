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
  bool operator ==(Object other) {
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
  String get nickname => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;
  List<String> get permissions => throw _privateConstructorUsedError;
  List<String> get auths => throw _privateConstructorUsedError;
  bool get isBindJw => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  int? get qq => throw _privateConstructorUsedError;
  String? get guildUserId => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get area => throw _privateConstructorUsedError;

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
      bool isBindJw,
      String? username,
      int? qq,
      String? guildUserId,
      String? phone,
      String? gender,
      String? area});
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
    Object? isBindJw = null,
    Object? username = freezed,
    Object? qq = freezed,
    Object? guildUserId = freezed,
    Object? phone = freezed,
    Object? gender = freezed,
    Object? area = freezed,
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
      isBindJw: null == isBindJw
          ? _value.isBindJw
          : isBindJw // ignore: cast_nullable_to_non_nullable
              as bool,
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
      bool isBindJw,
      String? username,
      int? qq,
      String? guildUserId,
      String? phone,
      String? gender,
      String? area});
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
    Object? isBindJw = null,
    Object? username = freezed,
    Object? qq = freezed,
    Object? guildUserId = freezed,
    Object? phone = freezed,
    Object? gender = freezed,
    Object? area = freezed,
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
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      auths: null == auths
          ? _value._auths
          : auths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isBindJw: null == isBindJw
          ? _value.isBindJw
          : isBindJw // ignore: cast_nullable_to_non_nullable
              as bool,
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
      required final List<String> permissions,
      required final List<String> auths,
      this.isBindJw = false,
      this.username,
      this.qq,
      this.guildUserId,
      this.phone,
      this.gender,
      this.area})
      : _permissions = permissions,
        _auths = auths;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final int id;
  @override
  final String nickname;
  @override
  final String avatarUrl;
  final List<String> _permissions;
  @override
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  final List<String> _auths;
  @override
  List<String> get auths {
    if (_auths is EqualUnmodifiableListView) return _auths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_auths);
  }

  @override
  @JsonKey()
  final bool isBindJw;
  @override
  final String? username;
  @override
  final int? qq;
  @override
  final String? guildUserId;
  @override
  final String? phone;
  @override
  final String? gender;
  @override
  final String? area;

  @override
  String toString() {
    return 'User(id: $id, nickname: $nickname, avatarUrl: $avatarUrl, permissions: $permissions, auths: $auths, isBindJw: $isBindJw, username: $username, qq: $qq, guildUserId: $guildUserId, phone: $phone, gender: $gender, area: $area)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            const DeepCollectionEquality().equals(other._auths, _auths) &&
            (identical(other.isBindJw, isBindJw) ||
                other.isBindJw == isBindJw) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.qq, qq) || other.qq == qq) &&
            (identical(other.guildUserId, guildUserId) ||
                other.guildUserId == guildUserId) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.area, area) || other.area == area));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      nickname,
      avatarUrl,
      const DeepCollectionEquality().hash(_permissions),
      const DeepCollectionEquality().hash(_auths),
      isBindJw,
      username,
      qq,
      guildUserId,
      phone,
      gender,
      area);

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
      {required final int id,
      required final String nickname,
      required final String avatarUrl,
      required final List<String> permissions,
      required final List<String> auths,
      final bool isBindJw,
      final String? username,
      final int? qq,
      final String? guildUserId,
      final String? phone,
      final String? gender,
      final String? area}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  int get id;
  @override
  String get nickname;
  @override
  String get avatarUrl;
  @override
  List<String> get permissions;
  @override
  List<String> get auths;
  @override
  bool get isBindJw;
  @override
  String? get username;
  @override
  int? get qq;
  @override
  String? get guildUserId;
  @override
  String? get phone;
  @override
  String? get gender;
  @override
  String? get area;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserUpdate _$UserUpdateFromJson(Map<String, dynamic> json) {
  return _UserUpdate.fromJson(json);
}

/// @nodoc
mixin _$UserUpdate {
  String get nickname => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;
  String? get area => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserUpdateCopyWith<UserUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserUpdateCopyWith<$Res> {
  factory $UserUpdateCopyWith(
          UserUpdate value, $Res Function(UserUpdate) then) =
      _$UserUpdateCopyWithImpl<$Res, UserUpdate>;
  @useResult
  $Res call({String nickname, String avatarUrl, String? area, String? gender});
}

/// @nodoc
class _$UserUpdateCopyWithImpl<$Res, $Val extends UserUpdate>
    implements $UserUpdateCopyWith<$Res> {
  _$UserUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
    Object? avatarUrl = null,
    Object? area = freezed,
    Object? gender = freezed,
  }) {
    return _then(_value.copyWith(
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      area: freezed == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserUpdateImplCopyWith<$Res>
    implements $UserUpdateCopyWith<$Res> {
  factory _$$UserUpdateImplCopyWith(
          _$UserUpdateImpl value, $Res Function(_$UserUpdateImpl) then) =
      __$$UserUpdateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String nickname, String avatarUrl, String? area, String? gender});
}

/// @nodoc
class __$$UserUpdateImplCopyWithImpl<$Res>
    extends _$UserUpdateCopyWithImpl<$Res, _$UserUpdateImpl>
    implements _$$UserUpdateImplCopyWith<$Res> {
  __$$UserUpdateImplCopyWithImpl(
      _$UserUpdateImpl _value, $Res Function(_$UserUpdateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
    Object? avatarUrl = null,
    Object? area = freezed,
    Object? gender = freezed,
  }) {
    return _then(_$UserUpdateImpl(
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      area: freezed == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
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
class _$UserUpdateImpl implements _UserUpdate {
  _$UserUpdateImpl(
      {required this.nickname,
      required this.avatarUrl,
      this.area,
      this.gender});

  factory _$UserUpdateImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserUpdateImplFromJson(json);

  @override
  final String nickname;
  @override
  final String avatarUrl;
  @override
  final String? area;
  @override
  final String? gender;

  @override
  String toString() {
    return 'UserUpdate(nickname: $nickname, avatarUrl: $avatarUrl, area: $area, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserUpdateImpl &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.gender, gender) || other.gender == gender));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, nickname, avatarUrl, area, gender);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserUpdateImplCopyWith<_$UserUpdateImpl> get copyWith =>
      __$$UserUpdateImplCopyWithImpl<_$UserUpdateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserUpdateImplToJson(
      this,
    );
  }
}

abstract class _UserUpdate implements UserUpdate {
  factory _UserUpdate(
      {required final String nickname,
      required final String avatarUrl,
      final String? area,
      final String? gender}) = _$UserUpdateImpl;

  factory _UserUpdate.fromJson(Map<String, dynamic> json) =
      _$UserUpdateImpl.fromJson;

  @override
  String get nickname;
  @override
  String get avatarUrl;
  @override
  String? get area;
  @override
  String? get gender;
  @override
  @JsonKey(ignore: true)
  _$$UserUpdateImplCopyWith<_$UserUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  int get id => throw _privateConstructorUsedError;
  set id(int value) => throw _privateConstructorUsedError;
  String get area => throw _privateConstructorUsedError;
  set area(String value) => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  set content(String value) => throw _privateConstructorUsedError;
  List<String>? get images => throw _privateConstructorUsedError;
  set images(List<String>? value) => throw _privateConstructorUsedError;
  List<Comment>? get comments => throw _privateConstructorUsedError;
  set comments(List<Comment>? value) => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createTime => throw _privateConstructorUsedError;
  @DateTimeConverter()
  set createTime(DateTime value) => throw _privateConstructorUsedError;
  UserSmall get createBy => throw _privateConstructorUsedError;
  set createBy(UserSmall value) => throw _privateConstructorUsedError;
  String? get contact => throw _privateConstructorUsedError;
  set contact(String? value) => throw _privateConstructorUsedError;
  String? get contactType => throw _privateConstructorUsedError;
  set contactType(String? value) => throw _privateConstructorUsedError;
  int? get viewCount => throw _privateConstructorUsedError;
  set viewCount(int? value) => throw _privateConstructorUsedError;

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
      required this.images,
      required this.comments,
      @DateTimeConverter() required this.createTime,
      required this.createBy,
      required this.contact,
      required this.contactType,
      required this.viewCount});

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  @override
  int id;
  @override
  String area;
  @override
  String content;
  @override
  List<String>? images;
  @override
  List<Comment>? comments;
  @override
  @DateTimeConverter()
  DateTime createTime;
  @override
  UserSmall createBy;
  @override
  String? contact;
  @override
  String? contactType;
  @override
  int? viewCount;

  @override
  String toString() {
    return 'Post(id: $id, area: $area, content: $content, images: $images, comments: $comments, createTime: $createTime, createBy: $createBy, contact: $contact, contactType: $contactType, viewCount: $viewCount)';
  }

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
      {required int id,
      required String area,
      required String content,
      required List<String>? images,
      required List<Comment>? comments,
      @DateTimeConverter() required DateTime createTime,
      required UserSmall createBy,
      required String? contact,
      required String? contactType,
      required int? viewCount}) = _$PostImpl;

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  @override
  int get id;
  set id(int value);
  @override
  String get area;
  set area(String value);
  @override
  String get content;
  set content(String value);
  @override
  List<String>? get images;
  set images(List<String>? value);
  @override
  List<Comment>? get comments;
  set comments(List<Comment>? value);
  @override
  @DateTimeConverter()
  DateTime get createTime;
  @DateTimeConverter()
  set createTime(DateTime value);
  @override
  UserSmall get createBy;
  set createBy(UserSmall value);
  @override
  String? get contact;
  set contact(String? value);
  @override
  String? get contactType;
  set contactType(String? value);
  @override
  int? get viewCount;
  set viewCount(int? value);
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
  bool operator ==(Object other) {
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
  bool operator ==(Object other) {
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
  bool operator ==(Object other) {
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

PersonalTimetable _$PersonalTimetableFromJson(Map<String, dynamic> json) {
  return _PersonalTimetable.fromJson(json);
}

/// @nodoc
mixin _$PersonalTimetable {
  String get year => throw _privateConstructorUsedError;
  int get semester => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get openDay => throw _privateConstructorUsedError;
  List<Course> get courses => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PersonalTimetableCopyWith<PersonalTimetable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalTimetableCopyWith<$Res> {
  factory $PersonalTimetableCopyWith(
          PersonalTimetable value, $Res Function(PersonalTimetable) then) =
      _$PersonalTimetableCopyWithImpl<$Res, PersonalTimetable>;
  @useResult
  $Res call(
      {String year,
      int semester,
      @DateTimeConverter() DateTime openDay,
      List<Course> courses});
}

/// @nodoc
class _$PersonalTimetableCopyWithImpl<$Res, $Val extends PersonalTimetable>
    implements $PersonalTimetableCopyWith<$Res> {
  _$PersonalTimetableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? semester = null,
    Object? openDay = null,
    Object? courses = null,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      semester: null == semester
          ? _value.semester
          : semester // ignore: cast_nullable_to_non_nullable
              as int,
      openDay: null == openDay
          ? _value.openDay
          : openDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      courses: null == courses
          ? _value.courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<Course>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PersonalTimetableImplCopyWith<$Res>
    implements $PersonalTimetableCopyWith<$Res> {
  factory _$$PersonalTimetableImplCopyWith(_$PersonalTimetableImpl value,
          $Res Function(_$PersonalTimetableImpl) then) =
      __$$PersonalTimetableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String year,
      int semester,
      @DateTimeConverter() DateTime openDay,
      List<Course> courses});
}

/// @nodoc
class __$$PersonalTimetableImplCopyWithImpl<$Res>
    extends _$PersonalTimetableCopyWithImpl<$Res, _$PersonalTimetableImpl>
    implements _$$PersonalTimetableImplCopyWith<$Res> {
  __$$PersonalTimetableImplCopyWithImpl(_$PersonalTimetableImpl _value,
      $Res Function(_$PersonalTimetableImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? semester = null,
    Object? openDay = null,
    Object? courses = null,
  }) {
    return _then(_$PersonalTimetableImpl(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      semester: null == semester
          ? _value.semester
          : semester // ignore: cast_nullable_to_non_nullable
              as int,
      openDay: null == openDay
          ? _value.openDay
          : openDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      courses: null == courses
          ? _value._courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<Course>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonalTimetableImpl implements _PersonalTimetable {
  _$PersonalTimetableImpl(
      {required this.year,
      required this.semester,
      @DateTimeConverter() required this.openDay,
      required final List<Course> courses})
      : _courses = courses;

  factory _$PersonalTimetableImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersonalTimetableImplFromJson(json);

  @override
  final String year;
  @override
  final int semester;
  @override
  @DateTimeConverter()
  final DateTime openDay;
  final List<Course> _courses;
  @override
  List<Course> get courses {
    if (_courses is EqualUnmodifiableListView) return _courses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_courses);
  }

  @override
  String toString() {
    return 'PersonalTimetable(year: $year, semester: $semester, openDay: $openDay, courses: $courses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalTimetableImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.semester, semester) ||
                other.semester == semester) &&
            (identical(other.openDay, openDay) || other.openDay == openDay) &&
            const DeepCollectionEquality().equals(other._courses, _courses));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, year, semester, openDay,
      const DeepCollectionEquality().hash(_courses));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonalTimetableImplCopyWith<_$PersonalTimetableImpl> get copyWith =>
      __$$PersonalTimetableImplCopyWithImpl<_$PersonalTimetableImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PersonalTimetableImplToJson(
      this,
    );
  }
}

abstract class _PersonalTimetable implements PersonalTimetable {
  factory _PersonalTimetable(
      {required final String year,
      required final int semester,
      @DateTimeConverter() required final DateTime openDay,
      required final List<Course> courses}) = _$PersonalTimetableImpl;

  factory _PersonalTimetable.fromJson(Map<String, dynamic> json) =
      _$PersonalTimetableImpl.fromJson;

  @override
  String get year;
  @override
  int get semester;
  @override
  @DateTimeConverter()
  DateTime get openDay;
  @override
  List<Course> get courses;
  @override
  @JsonKey(ignore: true)
  _$$PersonalTimetableImplCopyWith<_$PersonalTimetableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Course _$CourseFromJson(Map<String, dynamic> json) {
  return _Course.fromJson(json);
}

/// @nodoc
mixin _$Course {
  int? get id => throw _privateConstructorUsedError;
  set id(int? value) => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  set name(String value) => throw _privateConstructorUsedError;
  String get teacher => throw _privateConstructorUsedError;
  set teacher(String value) => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  set location(String value) => throw _privateConstructorUsedError;
  Set<int> get weeks => throw _privateConstructorUsedError;
  set weeks(Set<int> value) => throw _privateConstructorUsedError;
  int get weekday => throw _privateConstructorUsedError;
  set weekday(int value) => throw _privateConstructorUsedError;
  int get startNode => throw _privateConstructorUsedError;
  set startNode(int value) => throw _privateConstructorUsedError;
  int get nodeCount => throw _privateConstructorUsedError;
  set nodeCount(int value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CourseCopyWith<Course> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseCopyWith<$Res> {
  factory $CourseCopyWith(Course value, $Res Function(Course) then) =
      _$CourseCopyWithImpl<$Res, Course>;
  @useResult
  $Res call(
      {int? id,
      String name,
      String teacher,
      String location,
      Set<int> weeks,
      int weekday,
      int startNode,
      int nodeCount});
}

/// @nodoc
class _$CourseCopyWithImpl<$Res, $Val extends Course>
    implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? teacher = null,
    Object? location = null,
    Object? weeks = null,
    Object? weekday = null,
    Object? startNode = null,
    Object? nodeCount = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      teacher: null == teacher
          ? _value.teacher
          : teacher // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      weeks: null == weeks
          ? _value.weeks
          : weeks // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      weekday: null == weekday
          ? _value.weekday
          : weekday // ignore: cast_nullable_to_non_nullable
              as int,
      startNode: null == startNode
          ? _value.startNode
          : startNode // ignore: cast_nullable_to_non_nullable
              as int,
      nodeCount: null == nodeCount
          ? _value.nodeCount
          : nodeCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CourseImplCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$$CourseImplCopyWith(
          _$CourseImpl value, $Res Function(_$CourseImpl) then) =
      __$$CourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String name,
      String teacher,
      String location,
      Set<int> weeks,
      int weekday,
      int startNode,
      int nodeCount});
}

/// @nodoc
class __$$CourseImplCopyWithImpl<$Res>
    extends _$CourseCopyWithImpl<$Res, _$CourseImpl>
    implements _$$CourseImplCopyWith<$Res> {
  __$$CourseImplCopyWithImpl(
      _$CourseImpl _value, $Res Function(_$CourseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? teacher = null,
    Object? location = null,
    Object? weeks = null,
    Object? weekday = null,
    Object? startNode = null,
    Object? nodeCount = null,
  }) {
    return _then(_$CourseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      teacher: null == teacher
          ? _value.teacher
          : teacher // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      weeks: null == weeks
          ? _value.weeks
          : weeks // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      weekday: null == weekday
          ? _value.weekday
          : weekday // ignore: cast_nullable_to_non_nullable
              as int,
      startNode: null == startNode
          ? _value.startNode
          : startNode // ignore: cast_nullable_to_non_nullable
              as int,
      nodeCount: null == nodeCount
          ? _value.nodeCount
          : nodeCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseImpl implements _Course {
  _$CourseImpl(
      {this.id,
      required this.name,
      required this.teacher,
      required this.location,
      required this.weeks,
      required this.weekday,
      required this.startNode,
      required this.nodeCount});

  factory _$CourseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseImplFromJson(json);

  @override
  int? id;
  @override
  String name;
  @override
  String teacher;
  @override
  String location;
  @override
  Set<int> weeks;
  @override
  int weekday;
  @override
  int startNode;
  @override
  int nodeCount;

  @override
  String toString() {
    return 'Course(id: $id, name: $name, teacher: $teacher, location: $location, weeks: $weeks, weekday: $weekday, startNode: $startNode, nodeCount: $nodeCount)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      __$$CourseImplCopyWithImpl<_$CourseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseImplToJson(
      this,
    );
  }
}

abstract class _Course implements Course {
  factory _Course(
      {int? id,
      required String name,
      required String teacher,
      required String location,
      required Set<int> weeks,
      required int weekday,
      required int startNode,
      required int nodeCount}) = _$CourseImpl;

  factory _Course.fromJson(Map<String, dynamic> json) = _$CourseImpl.fromJson;

  @override
  int? get id;
  set id(int? value);
  @override
  String get name;
  set name(String value);
  @override
  String get teacher;
  set teacher(String value);
  @override
  String get location;
  set location(String value);
  @override
  Set<int> get weeks;
  set weeks(Set<int> value);
  @override
  int get weekday;
  set weekday(int value);
  @override
  int get startNode;
  set startNode(int value);
  @override
  int get nodeCount;
  set nodeCount(int value);
  @override
  @JsonKey(ignore: true)
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Score _$ScoreFromJson(Map<String, dynamic> json) {
  return _Score.fromJson(json);
}

/// @nodoc
mixin _$Score {
  int get id => throw _privateConstructorUsedError;
  set id(int value) => throw _privateConstructorUsedError;
  String get year => throw _privateConstructorUsedError;
  set year(String value) => throw _privateConstructorUsedError;
  int get term => throw _privateConstructorUsedError;
  set term(int value) => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  set name(String value) => throw _privateConstructorUsedError;
  String get nature => throw _privateConstructorUsedError;
  set nature(String value) => throw _privateConstructorUsedError;
  bool get iesIgnore => throw _privateConstructorUsedError;
  set iesIgnore(bool value) => throw _privateConstructorUsedError;
  String? get iesIgnoreReason => throw _privateConstructorUsedError;
  set iesIgnoreReason(String? value) => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;
  set score(double value) => throw _privateConstructorUsedError;
  double get makeupScore => throw _privateConstructorUsedError;
  set makeupScore(double value) => throw _privateConstructorUsedError;
  bool get isFree => throw _privateConstructorUsedError;
  set isFree(bool value) => throw _privateConstructorUsedError;
  double get gpa => throw _privateConstructorUsedError;
  set gpa(double value) => throw _privateConstructorUsedError;
  String get institute => throw _privateConstructorUsedError;
  set institute(String value) => throw _privateConstructorUsedError;
  String get attr => throw _privateConstructorUsedError;
  set attr(String value) => throw _privateConstructorUsedError;
  double get credit => throw _privateConstructorUsedError;
  set credit(double value) => throw _privateConstructorUsedError;
  bool get restudy => throw _privateConstructorUsedError;
  set restudy(bool value) => throw _privateConstructorUsedError;
  String? get remarks => throw _privateConstructorUsedError;
  set remarks(String? value) => throw _privateConstructorUsedError;
  String? get makeupRemarks => throw _privateConstructorUsedError;
  set makeupRemarks(String? value) => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  set userId(int value) => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createTime => throw _privateConstructorUsedError;
  @DateTimeConverter()
  set createTime(DateTime value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScoreCopyWith<Score> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreCopyWith<$Res> {
  factory $ScoreCopyWith(Score value, $Res Function(Score) then) =
      _$ScoreCopyWithImpl<$Res, Score>;
  @useResult
  $Res call(
      {int id,
      String year,
      int term,
      String name,
      String nature,
      bool iesIgnore,
      String? iesIgnoreReason,
      double score,
      double makeupScore,
      bool isFree,
      double gpa,
      String institute,
      String attr,
      double credit,
      bool restudy,
      String? remarks,
      String? makeupRemarks,
      int userId,
      @DateTimeConverter() DateTime createTime});
}

/// @nodoc
class _$ScoreCopyWithImpl<$Res, $Val extends Score>
    implements $ScoreCopyWith<$Res> {
  _$ScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? year = null,
    Object? term = null,
    Object? name = null,
    Object? nature = null,
    Object? iesIgnore = null,
    Object? iesIgnoreReason = freezed,
    Object? score = null,
    Object? makeupScore = null,
    Object? isFree = null,
    Object? gpa = null,
    Object? institute = null,
    Object? attr = null,
    Object? credit = null,
    Object? restudy = null,
    Object? remarks = freezed,
    Object? makeupRemarks = freezed,
    Object? userId = null,
    Object? createTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nature: null == nature
          ? _value.nature
          : nature // ignore: cast_nullable_to_non_nullable
              as String,
      iesIgnore: null == iesIgnore
          ? _value.iesIgnore
          : iesIgnore // ignore: cast_nullable_to_non_nullable
              as bool,
      iesIgnoreReason: freezed == iesIgnoreReason
          ? _value.iesIgnoreReason
          : iesIgnoreReason // ignore: cast_nullable_to_non_nullable
              as String?,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      makeupScore: null == makeupScore
          ? _value.makeupScore
          : makeupScore // ignore: cast_nullable_to_non_nullable
              as double,
      isFree: null == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
      gpa: null == gpa
          ? _value.gpa
          : gpa // ignore: cast_nullable_to_non_nullable
              as double,
      institute: null == institute
          ? _value.institute
          : institute // ignore: cast_nullable_to_non_nullable
              as String,
      attr: null == attr
          ? _value.attr
          : attr // ignore: cast_nullable_to_non_nullable
              as String,
      credit: null == credit
          ? _value.credit
          : credit // ignore: cast_nullable_to_non_nullable
              as double,
      restudy: null == restudy
          ? _value.restudy
          : restudy // ignore: cast_nullable_to_non_nullable
              as bool,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
              as String?,
      makeupRemarks: freezed == makeupRemarks
          ? _value.makeupRemarks
          : makeupRemarks // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      createTime: null == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScoreImplCopyWith<$Res> implements $ScoreCopyWith<$Res> {
  factory _$$ScoreImplCopyWith(
          _$ScoreImpl value, $Res Function(_$ScoreImpl) then) =
      __$$ScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String year,
      int term,
      String name,
      String nature,
      bool iesIgnore,
      String? iesIgnoreReason,
      double score,
      double makeupScore,
      bool isFree,
      double gpa,
      String institute,
      String attr,
      double credit,
      bool restudy,
      String? remarks,
      String? makeupRemarks,
      int userId,
      @DateTimeConverter() DateTime createTime});
}

/// @nodoc
class __$$ScoreImplCopyWithImpl<$Res>
    extends _$ScoreCopyWithImpl<$Res, _$ScoreImpl>
    implements _$$ScoreImplCopyWith<$Res> {
  __$$ScoreImplCopyWithImpl(
      _$ScoreImpl _value, $Res Function(_$ScoreImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? year = null,
    Object? term = null,
    Object? name = null,
    Object? nature = null,
    Object? iesIgnore = null,
    Object? iesIgnoreReason = freezed,
    Object? score = null,
    Object? makeupScore = null,
    Object? isFree = null,
    Object? gpa = null,
    Object? institute = null,
    Object? attr = null,
    Object? credit = null,
    Object? restudy = null,
    Object? remarks = freezed,
    Object? makeupRemarks = freezed,
    Object? userId = null,
    Object? createTime = null,
  }) {
    return _then(_$ScoreImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nature: null == nature
          ? _value.nature
          : nature // ignore: cast_nullable_to_non_nullable
              as String,
      iesIgnore: null == iesIgnore
          ? _value.iesIgnore
          : iesIgnore // ignore: cast_nullable_to_non_nullable
              as bool,
      iesIgnoreReason: freezed == iesIgnoreReason
          ? _value.iesIgnoreReason
          : iesIgnoreReason // ignore: cast_nullable_to_non_nullable
              as String?,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      makeupScore: null == makeupScore
          ? _value.makeupScore
          : makeupScore // ignore: cast_nullable_to_non_nullable
              as double,
      isFree: null == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
      gpa: null == gpa
          ? _value.gpa
          : gpa // ignore: cast_nullable_to_non_nullable
              as double,
      institute: null == institute
          ? _value.institute
          : institute // ignore: cast_nullable_to_non_nullable
              as String,
      attr: null == attr
          ? _value.attr
          : attr // ignore: cast_nullable_to_non_nullable
              as String,
      credit: null == credit
          ? _value.credit
          : credit // ignore: cast_nullable_to_non_nullable
              as double,
      restudy: null == restudy
          ? _value.restudy
          : restudy // ignore: cast_nullable_to_non_nullable
              as bool,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
              as String?,
      makeupRemarks: freezed == makeupRemarks
          ? _value.makeupRemarks
          : makeupRemarks // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      createTime: null == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScoreImpl implements _Score {
  _$ScoreImpl(
      {required this.id,
      required this.year,
      required this.term,
      required this.name,
      required this.nature,
      required this.iesIgnore,
      required this.iesIgnoreReason,
      required this.score,
      required this.makeupScore,
      required this.isFree,
      required this.gpa,
      required this.institute,
      required this.attr,
      required this.credit,
      required this.restudy,
      this.remarks,
      this.makeupRemarks,
      required this.userId,
      @DateTimeConverter() required this.createTime});

  factory _$ScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScoreImplFromJson(json);

  @override
  int id;
  @override
  String year;
  @override
  int term;
  @override
  String name;
  @override
  String nature;
  @override
  bool iesIgnore;
  @override
  String? iesIgnoreReason;
  @override
  double score;
  @override
  double makeupScore;
  @override
  bool isFree;
  @override
  double gpa;
  @override
  String institute;
  @override
  String attr;
  @override
  double credit;
  @override
  bool restudy;
  @override
  String? remarks;
  @override
  String? makeupRemarks;
  @override
  int userId;
  @override
  @DateTimeConverter()
  DateTime createTime;

  @override
  String toString() {
    return 'Score(id: $id, year: $year, term: $term, name: $name, nature: $nature, iesIgnore: $iesIgnore, iesIgnoreReason: $iesIgnoreReason, score: $score, makeupScore: $makeupScore, isFree: $isFree, gpa: $gpa, institute: $institute, attr: $attr, credit: $credit, restudy: $restudy, remarks: $remarks, makeupRemarks: $makeupRemarks, userId: $userId, createTime: $createTime)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScoreImplCopyWith<_$ScoreImpl> get copyWith =>
      __$$ScoreImplCopyWithImpl<_$ScoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScoreImplToJson(
      this,
    );
  }
}

abstract class _Score implements Score {
  factory _Score(
      {required int id,
      required String year,
      required int term,
      required String name,
      required String nature,
      required bool iesIgnore,
      required String? iesIgnoreReason,
      required double score,
      required double makeupScore,
      required bool isFree,
      required double gpa,
      required String institute,
      required String attr,
      required double credit,
      required bool restudy,
      String? remarks,
      String? makeupRemarks,
      required int userId,
      @DateTimeConverter() required DateTime createTime}) = _$ScoreImpl;

  factory _Score.fromJson(Map<String, dynamic> json) = _$ScoreImpl.fromJson;

  @override
  int get id;
  set id(int value);
  @override
  String get year;
  set year(String value);
  @override
  int get term;
  set term(int value);
  @override
  String get name;
  set name(String value);
  @override
  String get nature;
  set nature(String value);
  @override
  bool get iesIgnore;
  set iesIgnore(bool value);
  @override
  String? get iesIgnoreReason;
  set iesIgnoreReason(String? value);
  @override
  double get score;
  set score(double value);
  @override
  double get makeupScore;
  set makeupScore(double value);
  @override
  bool get isFree;
  set isFree(bool value);
  @override
  double get gpa;
  set gpa(double value);
  @override
  String get institute;
  set institute(String value);
  @override
  String get attr;
  set attr(String value);
  @override
  double get credit;
  set credit(double value);
  @override
  bool get restudy;
  set restudy(bool value);
  @override
  String? get remarks;
  set remarks(String? value);
  @override
  String? get makeupRemarks;
  set makeupRemarks(String? value);
  @override
  int get userId;
  set userId(int value);
  @override
  @DateTimeConverter()
  DateTime get createTime;
  @DateTimeConverter()
  set createTime(DateTime value);
  @override
  @JsonKey(ignore: true)
  _$$ScoreImplCopyWith<_$ScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScoreTable _$ScoreTableFromJson(Map<String, dynamic> json) {
  return _ScoreTable.fromJson(json);
}

/// @nodoc
mixin _$ScoreTable {
  SemesterOptions get options => throw _privateConstructorUsedError;
  set options(SemesterOptions value) => throw _privateConstructorUsedError;
  List<Score> get data => throw _privateConstructorUsedError;
  set data(List<Score> value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScoreTableCopyWith<ScoreTable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreTableCopyWith<$Res> {
  factory $ScoreTableCopyWith(
          ScoreTable value, $Res Function(ScoreTable) then) =
      _$ScoreTableCopyWithImpl<$Res, ScoreTable>;
  @useResult
  $Res call({SemesterOptions options, List<Score> data});

  $SemesterOptionsCopyWith<$Res> get options;
}

/// @nodoc
class _$ScoreTableCopyWithImpl<$Res, $Val extends ScoreTable>
    implements $ScoreTableCopyWith<$Res> {
  _$ScoreTableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? options = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as SemesterOptions,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Score>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SemesterOptionsCopyWith<$Res> get options {
    return $SemesterOptionsCopyWith<$Res>(_value.options, (value) {
      return _then(_value.copyWith(options: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScoreTableImplCopyWith<$Res>
    implements $ScoreTableCopyWith<$Res> {
  factory _$$ScoreTableImplCopyWith(
          _$ScoreTableImpl value, $Res Function(_$ScoreTableImpl) then) =
      __$$ScoreTableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SemesterOptions options, List<Score> data});

  @override
  $SemesterOptionsCopyWith<$Res> get options;
}

/// @nodoc
class __$$ScoreTableImplCopyWithImpl<$Res>
    extends _$ScoreTableCopyWithImpl<$Res, _$ScoreTableImpl>
    implements _$$ScoreTableImplCopyWith<$Res> {
  __$$ScoreTableImplCopyWithImpl(
      _$ScoreTableImpl _value, $Res Function(_$ScoreTableImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? options = null,
    Object? data = null,
  }) {
    return _then(_$ScoreTableImpl(
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as SemesterOptions,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Score>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScoreTableImpl implements _ScoreTable {
  _$ScoreTableImpl({required this.options, required this.data});

  factory _$ScoreTableImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScoreTableImplFromJson(json);

  @override
  SemesterOptions options;
  @override
  List<Score> data;

  @override
  String toString() {
    return 'ScoreTable(options: $options, data: $data)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScoreTableImplCopyWith<_$ScoreTableImpl> get copyWith =>
      __$$ScoreTableImplCopyWithImpl<_$ScoreTableImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScoreTableImplToJson(
      this,
    );
  }
}

abstract class _ScoreTable implements ScoreTable {
  factory _ScoreTable(
      {required SemesterOptions options,
      required List<Score> data}) = _$ScoreTableImpl;

  factory _ScoreTable.fromJson(Map<String, dynamic> json) =
      _$ScoreTableImpl.fromJson;

  @override
  SemesterOptions get options;
  set options(SemesterOptions value);
  @override
  List<Score> get data;
  set data(List<Score> value);
  @override
  @JsonKey(ignore: true)
  _$$ScoreTableImplCopyWith<_$ScoreTableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SemesterOptions _$SemesterOptionsFromJson(Map<String, dynamic> json) {
  return _SemesterOptions.fromJson(json);
}

/// @nodoc
mixin _$SemesterOptions {
  List<String> get years => throw _privateConstructorUsedError;
  List<int> get terms => throw _privateConstructorUsedError;
  int get defaultYearIndex => throw _privateConstructorUsedError;
  int get defaultTermIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SemesterOptionsCopyWith<SemesterOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SemesterOptionsCopyWith<$Res> {
  factory $SemesterOptionsCopyWith(
          SemesterOptions value, $Res Function(SemesterOptions) then) =
      _$SemesterOptionsCopyWithImpl<$Res, SemesterOptions>;
  @useResult
  $Res call(
      {List<String> years,
      List<int> terms,
      int defaultYearIndex,
      int defaultTermIndex});
}

/// @nodoc
class _$SemesterOptionsCopyWithImpl<$Res, $Val extends SemesterOptions>
    implements $SemesterOptionsCopyWith<$Res> {
  _$SemesterOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? years = null,
    Object? terms = null,
    Object? defaultYearIndex = null,
    Object? defaultTermIndex = null,
  }) {
    return _then(_value.copyWith(
      years: null == years
          ? _value.years
          : years // ignore: cast_nullable_to_non_nullable
              as List<String>,
      terms: null == terms
          ? _value.terms
          : terms // ignore: cast_nullable_to_non_nullable
              as List<int>,
      defaultYearIndex: null == defaultYearIndex
          ? _value.defaultYearIndex
          : defaultYearIndex // ignore: cast_nullable_to_non_nullable
              as int,
      defaultTermIndex: null == defaultTermIndex
          ? _value.defaultTermIndex
          : defaultTermIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SemesterOptionsImplCopyWith<$Res>
    implements $SemesterOptionsCopyWith<$Res> {
  factory _$$SemesterOptionsImplCopyWith(_$SemesterOptionsImpl value,
          $Res Function(_$SemesterOptionsImpl) then) =
      __$$SemesterOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> years,
      List<int> terms,
      int defaultYearIndex,
      int defaultTermIndex});
}

/// @nodoc
class __$$SemesterOptionsImplCopyWithImpl<$Res>
    extends _$SemesterOptionsCopyWithImpl<$Res, _$SemesterOptionsImpl>
    implements _$$SemesterOptionsImplCopyWith<$Res> {
  __$$SemesterOptionsImplCopyWithImpl(
      _$SemesterOptionsImpl _value, $Res Function(_$SemesterOptionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? years = null,
    Object? terms = null,
    Object? defaultYearIndex = null,
    Object? defaultTermIndex = null,
  }) {
    return _then(_$SemesterOptionsImpl(
      years: null == years
          ? _value._years
          : years // ignore: cast_nullable_to_non_nullable
              as List<String>,
      terms: null == terms
          ? _value._terms
          : terms // ignore: cast_nullable_to_non_nullable
              as List<int>,
      defaultYearIndex: null == defaultYearIndex
          ? _value.defaultYearIndex
          : defaultYearIndex // ignore: cast_nullable_to_non_nullable
              as int,
      defaultTermIndex: null == defaultTermIndex
          ? _value.defaultTermIndex
          : defaultTermIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SemesterOptionsImpl implements _SemesterOptions {
  _$SemesterOptionsImpl(
      {required final List<String> years,
      required final List<int> terms,
      required this.defaultYearIndex,
      required this.defaultTermIndex})
      : _years = years,
        _terms = terms;

  factory _$SemesterOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SemesterOptionsImplFromJson(json);

  final List<String> _years;
  @override
  List<String> get years {
    if (_years is EqualUnmodifiableListView) return _years;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_years);
  }

  final List<int> _terms;
  @override
  List<int> get terms {
    if (_terms is EqualUnmodifiableListView) return _terms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_terms);
  }

  @override
  final int defaultYearIndex;
  @override
  final int defaultTermIndex;

  @override
  String toString() {
    return 'SemesterOptions(years: $years, terms: $terms, defaultYearIndex: $defaultYearIndex, defaultTermIndex: $defaultTermIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SemesterOptionsImpl &&
            const DeepCollectionEquality().equals(other._years, _years) &&
            const DeepCollectionEquality().equals(other._terms, _terms) &&
            (identical(other.defaultYearIndex, defaultYearIndex) ||
                other.defaultYearIndex == defaultYearIndex) &&
            (identical(other.defaultTermIndex, defaultTermIndex) ||
                other.defaultTermIndex == defaultTermIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_years),
      const DeepCollectionEquality().hash(_terms),
      defaultYearIndex,
      defaultTermIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SemesterOptionsImplCopyWith<_$SemesterOptionsImpl> get copyWith =>
      __$$SemesterOptionsImplCopyWithImpl<_$SemesterOptionsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SemesterOptionsImplToJson(
      this,
    );
  }
}

abstract class _SemesterOptions implements SemesterOptions {
  factory _SemesterOptions(
      {required final List<String> years,
      required final List<int> terms,
      required final int defaultYearIndex,
      required final int defaultTermIndex}) = _$SemesterOptionsImpl;

  factory _SemesterOptions.fromJson(Map<String, dynamic> json) =
      _$SemesterOptionsImpl.fromJson;

  @override
  List<String> get years;
  @override
  List<int> get terms;
  @override
  int get defaultYearIndex;
  @override
  int get defaultTermIndex;
  @override
  @JsonKey(ignore: true)
  _$$SemesterOptionsImplCopyWith<_$SemesterOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Term _$TermFromJson(Map<String, dynamic> json) {
  return _Term.fromJson(json);
}

/// @nodoc
mixin _$Term {
  String get year => throw _privateConstructorUsedError;
  String get term => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TermCopyWith<Term> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermCopyWith<$Res> {
  factory $TermCopyWith(Term value, $Res Function(Term) then) =
      _$TermCopyWithImpl<$Res, Term>;
  @useResult
  $Res call({String year, String term});
}

/// @nodoc
class _$TermCopyWithImpl<$Res, $Val extends Term>
    implements $TermCopyWith<$Res> {
  _$TermCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? term = null,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TermImplCopyWith<$Res> implements $TermCopyWith<$Res> {
  factory _$$TermImplCopyWith(
          _$TermImpl value, $Res Function(_$TermImpl) then) =
      __$$TermImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String year, String term});
}

/// @nodoc
class __$$TermImplCopyWithImpl<$Res>
    extends _$TermCopyWithImpl<$Res, _$TermImpl>
    implements _$$TermImplCopyWith<$Res> {
  __$$TermImplCopyWithImpl(_$TermImpl _value, $Res Function(_$TermImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? term = null,
  }) {
    return _then(_$TermImpl(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TermImpl implements _Term {
  _$TermImpl({required this.year, required this.term});

  factory _$TermImpl.fromJson(Map<String, dynamic> json) =>
      _$$TermImplFromJson(json);

  @override
  final String year;
  @override
  final String term;

  @override
  String toString() {
    return 'Term(year: $year, term: $term)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.term, term) || other.term == term));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, year, term);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TermImplCopyWith<_$TermImpl> get copyWith =>
      __$$TermImplCopyWithImpl<_$TermImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TermImplToJson(
      this,
    );
  }
}

abstract class _Term implements Term {
  factory _Term({required final String year, required final String term}) =
      _$TermImpl;

  factory _Term.fromJson(Map<String, dynamic> json) = _$TermImpl.fromJson;

  @override
  String get year;
  @override
  String get term;
  @override
  @JsonKey(ignore: true)
  _$$TermImplCopyWith<_$TermImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimetableSet _$TimetableSetFromJson(Map<String, dynamic> json) {
  return _TimetableSet.fromJson(json);
}

/// @nodoc
mixin _$TimetableSet {
  int? get timeIndex => throw _privateConstructorUsedError;
  set timeIndex(int? value) => throw _privateConstructorUsedError;
  bool get showTime => throw _privateConstructorUsedError;
  set showTime(bool value) => throw _privateConstructorUsedError;
  String? get backgroundPath => throw _privateConstructorUsedError;
  set backgroundPath(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimetableSetCopyWith<TimetableSet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimetableSetCopyWith<$Res> {
  factory $TimetableSetCopyWith(
          TimetableSet value, $Res Function(TimetableSet) then) =
      _$TimetableSetCopyWithImpl<$Res, TimetableSet>;
  @useResult
  $Res call({int? timeIndex, bool showTime, String? backgroundPath});
}

/// @nodoc
class _$TimetableSetCopyWithImpl<$Res, $Val extends TimetableSet>
    implements $TimetableSetCopyWith<$Res> {
  _$TimetableSetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeIndex = freezed,
    Object? showTime = null,
    Object? backgroundPath = freezed,
  }) {
    return _then(_value.copyWith(
      timeIndex: freezed == timeIndex
          ? _value.timeIndex
          : timeIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      showTime: null == showTime
          ? _value.showTime
          : showTime // ignore: cast_nullable_to_non_nullable
              as bool,
      backgroundPath: freezed == backgroundPath
          ? _value.backgroundPath
          : backgroundPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimetableSetImplCopyWith<$Res>
    implements $TimetableSetCopyWith<$Res> {
  factory _$$TimetableSetImplCopyWith(
          _$TimetableSetImpl value, $Res Function(_$TimetableSetImpl) then) =
      __$$TimetableSetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? timeIndex, bool showTime, String? backgroundPath});
}

/// @nodoc
class __$$TimetableSetImplCopyWithImpl<$Res>
    extends _$TimetableSetCopyWithImpl<$Res, _$TimetableSetImpl>
    implements _$$TimetableSetImplCopyWith<$Res> {
  __$$TimetableSetImplCopyWithImpl(
      _$TimetableSetImpl _value, $Res Function(_$TimetableSetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeIndex = freezed,
    Object? showTime = null,
    Object? backgroundPath = freezed,
  }) {
    return _then(_$TimetableSetImpl(
      timeIndex: freezed == timeIndex
          ? _value.timeIndex
          : timeIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      showTime: null == showTime
          ? _value.showTime
          : showTime // ignore: cast_nullable_to_non_nullable
              as bool,
      backgroundPath: freezed == backgroundPath
          ? _value.backgroundPath
          : backgroundPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimetableSetImpl implements _TimetableSet {
  _$TimetableSetImpl(
      {this.timeIndex = null, this.showTime = true, this.backgroundPath});

  factory _$TimetableSetImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimetableSetImplFromJson(json);

  @override
  @JsonKey()
  int? timeIndex;
  @override
  @JsonKey()
  bool showTime;
  @override
  String? backgroundPath;

  @override
  String toString() {
    return 'TimetableSet(timeIndex: $timeIndex, showTime: $showTime, backgroundPath: $backgroundPath)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimetableSetImplCopyWith<_$TimetableSetImpl> get copyWith =>
      __$$TimetableSetImplCopyWithImpl<_$TimetableSetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimetableSetImplToJson(
      this,
    );
  }
}

abstract class _TimetableSet implements TimetableSet {
  factory _TimetableSet(
      {int? timeIndex,
      bool showTime,
      String? backgroundPath}) = _$TimetableSetImpl;

  factory _TimetableSet.fromJson(Map<String, dynamic> json) =
      _$TimetableSetImpl.fromJson;

  @override
  int? get timeIndex;
  set timeIndex(int? value);
  @override
  bool get showTime;
  set showTime(bool value);
  @override
  String? get backgroundPath;
  set backgroundPath(String? value);
  @override
  @JsonKey(ignore: true)
  _$$TimetableSetImplCopyWith<_$TimetableSetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  String get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call({String type, Map<String, dynamic> data});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, Map<String, dynamic> data});
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? data = null,
  }) {
    return _then(_$MessageImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl implements _Message {
  _$MessageImpl({required this.type, required final Map<String, dynamic> data})
      : _data = data;

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  final String type;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'Message(type: $type, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  factory _Message(
      {required final String type,
      required final Map<String, dynamic> data}) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  String get type;
  @override
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MajorTimetable _$MajorTimetableFromJson(Map<String, dynamic> json) {
  return _MajorTimetable.fromJson(json);
}

/// @nodoc
mixin _$MajorTimetable {
  String get major => throw _privateConstructorUsedError;
  String get grade => throw _privateConstructorUsedError;
  String get clazz => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get updateTime => throw _privateConstructorUsedError;
  List<Course> get courses => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MajorTimetableCopyWith<MajorTimetable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MajorTimetableCopyWith<$Res> {
  factory $MajorTimetableCopyWith(
          MajorTimetable value, $Res Function(MajorTimetable) then) =
      _$MajorTimetableCopyWithImpl<$Res, MajorTimetable>;
  @useResult
  $Res call(
      {String major,
      String grade,
      String clazz,
      @DateTimeConverter() DateTime updateTime,
      List<Course> courses});
}

/// @nodoc
class _$MajorTimetableCopyWithImpl<$Res, $Val extends MajorTimetable>
    implements $MajorTimetableCopyWith<$Res> {
  _$MajorTimetableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? major = null,
    Object? grade = null,
    Object? clazz = null,
    Object? updateTime = null,
    Object? courses = null,
  }) {
    return _then(_value.copyWith(
      major: null == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as String,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String,
      clazz: null == clazz
          ? _value.clazz
          : clazz // ignore: cast_nullable_to_non_nullable
              as String,
      updateTime: null == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      courses: null == courses
          ? _value.courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<Course>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MajorTimetableImplCopyWith<$Res>
    implements $MajorTimetableCopyWith<$Res> {
  factory _$$MajorTimetableImplCopyWith(_$MajorTimetableImpl value,
          $Res Function(_$MajorTimetableImpl) then) =
      __$$MajorTimetableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String major,
      String grade,
      String clazz,
      @DateTimeConverter() DateTime updateTime,
      List<Course> courses});
}

/// @nodoc
class __$$MajorTimetableImplCopyWithImpl<$Res>
    extends _$MajorTimetableCopyWithImpl<$Res, _$MajorTimetableImpl>
    implements _$$MajorTimetableImplCopyWith<$Res> {
  __$$MajorTimetableImplCopyWithImpl(
      _$MajorTimetableImpl _value, $Res Function(_$MajorTimetableImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? major = null,
    Object? grade = null,
    Object? clazz = null,
    Object? updateTime = null,
    Object? courses = null,
  }) {
    return _then(_$MajorTimetableImpl(
      major: null == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as String,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String,
      clazz: null == clazz
          ? _value.clazz
          : clazz // ignore: cast_nullable_to_non_nullable
              as String,
      updateTime: null == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      courses: null == courses
          ? _value._courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<Course>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MajorTimetableImpl implements _MajorTimetable {
  _$MajorTimetableImpl(
      {required this.major,
      required this.grade,
      required this.clazz,
      @DateTimeConverter() required this.updateTime,
      required final List<Course> courses})
      : _courses = courses;

  factory _$MajorTimetableImpl.fromJson(Map<String, dynamic> json) =>
      _$$MajorTimetableImplFromJson(json);

  @override
  final String major;
  @override
  final String grade;
  @override
  final String clazz;
  @override
  @DateTimeConverter()
  final DateTime updateTime;
  final List<Course> _courses;
  @override
  List<Course> get courses {
    if (_courses is EqualUnmodifiableListView) return _courses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_courses);
  }

  @override
  String toString() {
    return 'MajorTimetable(major: $major, grade: $grade, clazz: $clazz, updateTime: $updateTime, courses: $courses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MajorTimetableImpl &&
            (identical(other.major, major) || other.major == major) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.clazz, clazz) || other.clazz == clazz) &&
            (identical(other.updateTime, updateTime) ||
                other.updateTime == updateTime) &&
            const DeepCollectionEquality().equals(other._courses, _courses));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, major, grade, clazz, updateTime,
      const DeepCollectionEquality().hash(_courses));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MajorTimetableImplCopyWith<_$MajorTimetableImpl> get copyWith =>
      __$$MajorTimetableImplCopyWithImpl<_$MajorTimetableImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MajorTimetableImplToJson(
      this,
    );
  }
}

abstract class _MajorTimetable implements MajorTimetable {
  factory _MajorTimetable(
      {required final String major,
      required final String grade,
      required final String clazz,
      @DateTimeConverter() required final DateTime updateTime,
      required final List<Course> courses}) = _$MajorTimetableImpl;

  factory _MajorTimetable.fromJson(Map<String, dynamic> json) =
      _$MajorTimetableImpl.fromJson;

  @override
  String get major;
  @override
  String get grade;
  @override
  String get clazz;
  @override
  @DateTimeConverter()
  DateTime get updateTime;
  @override
  List<Course> get courses;
  @override
  @JsonKey(ignore: true)
  _$$MajorTimetableImplCopyWith<_$MajorTimetableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppUpdate _$AppUpdateFromJson(Map<String, dynamic> json) {
  return _AppUpdate.fromJson(json);
}

/// @nodoc
mixin _$AppUpdate {
  int get id => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get platform => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get force => throw _privateConstructorUsedError; // 应用更新的最大通知次数
  int get noticeTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUpdateCopyWith<AppUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUpdateCopyWith<$Res> {
  factory $AppUpdateCopyWith(AppUpdate value, $Res Function(AppUpdate) then) =
      _$AppUpdateCopyWithImpl<$Res, AppUpdate>;
  @useResult
  $Res call(
      {int id,
      String version,
      int code,
      String platform,
      String url,
      String description,
      bool force,
      int noticeTime});
}

/// @nodoc
class _$AppUpdateCopyWithImpl<$Res, $Val extends AppUpdate>
    implements $AppUpdateCopyWith<$Res> {
  _$AppUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? version = null,
    Object? code = null,
    Object? platform = null,
    Object? url = null,
    Object? description = null,
    Object? force = null,
    Object? noticeTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      force: null == force
          ? _value.force
          : force // ignore: cast_nullable_to_non_nullable
              as bool,
      noticeTime: null == noticeTime
          ? _value.noticeTime
          : noticeTime // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppUpdateImplCopyWith<$Res>
    implements $AppUpdateCopyWith<$Res> {
  factory _$$AppUpdateImplCopyWith(
          _$AppUpdateImpl value, $Res Function(_$AppUpdateImpl) then) =
      __$$AppUpdateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String version,
      int code,
      String platform,
      String url,
      String description,
      bool force,
      int noticeTime});
}

/// @nodoc
class __$$AppUpdateImplCopyWithImpl<$Res>
    extends _$AppUpdateCopyWithImpl<$Res, _$AppUpdateImpl>
    implements _$$AppUpdateImplCopyWith<$Res> {
  __$$AppUpdateImplCopyWithImpl(
      _$AppUpdateImpl _value, $Res Function(_$AppUpdateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? version = null,
    Object? code = null,
    Object? platform = null,
    Object? url = null,
    Object? description = null,
    Object? force = null,
    Object? noticeTime = null,
  }) {
    return _then(_$AppUpdateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      force: null == force
          ? _value.force
          : force // ignore: cast_nullable_to_non_nullable
              as bool,
      noticeTime: null == noticeTime
          ? _value.noticeTime
          : noticeTime // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppUpdateImpl implements _AppUpdate {
  _$AppUpdateImpl(
      {required this.id,
      required this.version,
      required this.code,
      required this.platform,
      required this.url,
      required this.description,
      required this.force,
      required this.noticeTime});

  factory _$AppUpdateImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUpdateImplFromJson(json);

  @override
  final int id;
  @override
  final String version;
  @override
  final int code;
  @override
  final String platform;
  @override
  final String url;
  @override
  final String description;
  @override
  final bool force;
// 应用更新的最大通知次数
  @override
  final int noticeTime;

  @override
  String toString() {
    return 'AppUpdate(id: $id, version: $version, code: $code, platform: $platform, url: $url, description: $description, force: $force, noticeTime: $noticeTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUpdateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.force, force) || other.force == force) &&
            (identical(other.noticeTime, noticeTime) ||
                other.noticeTime == noticeTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, version, code, platform, url,
      description, force, noticeTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUpdateImplCopyWith<_$AppUpdateImpl> get copyWith =>
      __$$AppUpdateImplCopyWithImpl<_$AppUpdateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUpdateImplToJson(
      this,
    );
  }
}

abstract class _AppUpdate implements AppUpdate {
  factory _AppUpdate(
      {required final int id,
      required final String version,
      required final int code,
      required final String platform,
      required final String url,
      required final String description,
      required final bool force,
      required final int noticeTime}) = _$AppUpdateImpl;

  factory _AppUpdate.fromJson(Map<String, dynamic> json) =
      _$AppUpdateImpl.fromJson;

  @override
  int get id;
  @override
  String get version;
  @override
  int get code;
  @override
  String get platform;
  @override
  String get url;
  @override
  String get description;
  @override
  bool get force;
  @override // 应用更新的最大通知次数
  int get noticeTime;
  @override
  @JsonKey(ignore: true)
  _$$AppUpdateImplCopyWith<_$AppUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
