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

@freezed
class User with _$User {
  factory User({
    required int id,
    required String nickname,
    required String avatarUrl,
    required List<String> permissions,
    required List<String> auths,
    @Default(false) bool isBindJw,
    String? username,
    int? qq,
    String? guildUserId,
    String? phone,
    String? gender,
    String? area,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class UserUpdate with _$UserUpdate {
  factory UserUpdate({
    required String nickname,
    required String avatarUrl,
    String? area,
    String? gender,
  }) = _UserUpdate;

  factory UserUpdate.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateFromJson(json);
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

  factory PostCreate.fromJson(Map<String, dynamic> json) =>
      _$PostCreateFromJson(json);
}

@freezed
class PersonalTimetable with _$PersonalTimetable {
  factory PersonalTimetable({
    required String year,
    required int semester,
    @DateTimeConverter() required DateTime openDay,
    required List<Course> courses,
  }) = _PersonalTimetable;

  factory PersonalTimetable.fromJson(Map<String, dynamic> json) =>
      _$PersonalTimetableFromJson(json);
}

@unfreezed
class Course with _$Course {
  factory Course({
    int? id,
    required String name,
    required String teacher,
    required String location,
    required Set<int> weeks,
    required int weekday,
    required int startNode,
    required int nodeCount,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

// get endNode => startNode + nodeCount - 1;
}

extension CourseExtentsion on Course {
  int get endNode {
    return startNode + nodeCount - 1;
  }
}

@unfreezed
class Score with _$Score {
  factory Score({
    required int id,
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
    @DateTimeConverter() required DateTime createTime,
  }) = _Score;

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
}

extension ScoreExtension on Score {
  /// 用于计算智育分的分数
  /// 返回-1时，则不计入智育分计算
  double get iesScore {
    final makeupScore = this.makeupScore;
    if (iesIgnore) {
      //不计入智育分计算
      return -1;
    } else if (makeupScore >= 60) {
      //补考成绩及格，以60分计算
      return 60;
    } else if (makeupScore != -1) {
      //补考成绩不及格，以补考成绩计算，并以学分1:1比例扣除相应智育分
      return makeupScore;
    } else {
      //成绩及格 或者 补考成绩未出
      return score;
    }
  }
}

@unfreezed
class ScoreTable with _$ScoreTable {
  factory ScoreTable({
    required SemesterOptions options,
    required List<Score> data,
  }) = _ScoreTable;

  factory ScoreTable.fromJson(Map<String, dynamic> json) =>
      _$ScoreTableFromJson(json);
}

@freezed
class SemesterOptions with _$SemesterOptions {
  factory SemesterOptions({
    required List<String> years,
    required List<int> terms,
    required int defaultYearIndex,
    required int defaultTermIndex,
  }) = _SemesterOptions;

  factory SemesterOptions.fromJson(Map<String, dynamic> json) =>
      _$SemesterOptionsFromJson(json);
}

@freezed
class Term with _$Term {
  factory Term({
    required String year,
    required String term,
  }) = _Term;

  factory Term.fromJson(Map<String, dynamic> json) => _$TermFromJson(json);
}

extension TermExtension on Term {
  String get title {
    if (year.isEmpty || term.isEmpty) {
      return '';
    } else {
      return '$year学年第$term学期';
    }
  }
}

@unfreezed
class TimetableSet with _$TimetableSet {
  factory TimetableSet({
    @Default(null) int? timeIndex,
    @Default(true) bool showTime,
    String? backgroundPath,
  }) = _TimetableSet;

  factory TimetableSet.fromJson(Map<String, dynamic> json) =>
      _$TimetableSetFromJson(json);

  /// 本科上课时间，下标为开始上课节数
  static const time0 = [
    0,
    800,
    850,
    955,
    1045,
    1135,
    1400,
    1450,
    1550,
    1640,
    1825,
    1915,
    2005
  ];

  /// 旗山上课时间，下标为开始上课节数
  static const time1 = [
    0,
    820,
    910,
    1010,
    1100,
    1150,
    1410,
    1500,
    1555,
    1645,
    1825,
    1915,
    2005
  ];

  static const List<List<int>> times = [time0, time1];
}

@freezed
class Message with _$Message {
  factory Message({
    required String type,
    required Map<String, dynamic> data,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

typedef MajorTimetableOptions = Map<String, Map<String, Map<String, int>>>;

@freezed
class MajorTimetable with _$MajorTimetable {
  factory MajorTimetable({
    required String major,
    required String grade,
    required String clazz,
    @DateTimeConverter() required DateTime updateTime,
    required List<Course> courses,
  }) = _MajorTimetable;

  factory MajorTimetable.fromJson(Map<String, dynamic> json) =>
      _$MajorTimetableFromJson(json);
}

@freezed
class AppUpdate with _$AppUpdate {
  factory AppUpdate({
    required int id,
    required String version,
    required int code,
    required String platform,
    required String url,
    required String description,
    required bool force,
    // 应用更新的最大通知次数
    required int noticeTime,
  }) = _AppUpdate;

  factory AppUpdate.fromJson(Map<String, dynamic> json) =>
      _$AppUpdateFromJson(json);
}
