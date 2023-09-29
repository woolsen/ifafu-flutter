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