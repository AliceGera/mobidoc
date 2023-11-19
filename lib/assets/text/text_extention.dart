import 'package:flutter/material.dart';
import 'package:flutter_template/assets/text/text_style.dart';

/// App text style scheme.
class AppTextTheme extends ThemeExtension<AppTextTheme> {
  /// Text style 14_140.
  final TextStyle regular14;

  /// Text style 16_124.
  final TextStyle regular16;

  final TextStyle medium12;

  /// Text style 14_140_500.
  final TextStyle medium14;

  /// Text style 16_124_500.
  final TextStyle medium16;

  final TextStyle semiBold12;

  final TextStyle semiBold14;

  final TextStyle semiBold16;

  final TextStyle semiBold18;

  /// Text style 14_140_700.
  final TextStyle bold14;

  /// Text style 16_124_700.
  final TextStyle bold16;

  final TextStyle bold20;

  final TextStyle bold22;

  final TextStyle bold24;

  final TextStyle bold30;

  AppTextTheme._({
    required this.regular14,
    required this.regular16,
    required this.medium12,
    required this.medium14,
    required this.medium16,
    required this.semiBold12,
    required this.semiBold14,
    required this.semiBold16,
    required this.semiBold18,
    required this.bold14,
    required this.bold16,
    required this.bold20,
    required this.bold22,
    required this.bold24,
    required this.bold30,
  });

  /// Base app text theme.
  AppTextTheme.base()
      : regular14 = AppTextStyle.regular14.value,
        regular16 = AppTextStyle.regular16.value,
        medium12 = AppTextStyle.medium12.value,
        medium14 = AppTextStyle.medium14.value,
        medium16 = AppTextStyle.medium16.value,
        semiBold12 = AppTextStyle.semiBold12.value,
        semiBold14 = AppTextStyle.semiBold14.value,
        semiBold16 = AppTextStyle.semiBold16.value,
        semiBold18 = AppTextStyle.semiBold18.value,
        bold14 = AppTextStyle.bold14.value,
        bold16 = AppTextStyle.bold16.value,
        bold20 = AppTextStyle.bold20.value,
        bold22 = AppTextStyle.bold22.value,
        bold24 = AppTextStyle.bold24.value,
        bold30 = AppTextStyle.bold30.value;

  @override
  ThemeExtension<AppTextTheme> lerp(
    ThemeExtension<AppTextTheme>? other,
    double t,
  ) {
    if (other is! AppTextTheme) {
      return this;
    }

    return AppTextTheme._(
      regular14: TextStyle.lerp(regular14, other.regular14, t)!,
      regular16: TextStyle.lerp(regular16, other.regular16, t)!,
      medium12: TextStyle.lerp(medium12, other.medium12, t)!,
      medium14: TextStyle.lerp(medium14, other.medium14, t)!,
      medium16: TextStyle.lerp(medium16, other.medium16, t)!,
      semiBold12: TextStyle.lerp(semiBold12, other.semiBold12, t)!,
      semiBold14: TextStyle.lerp(semiBold14, other.semiBold14, t)!,
      semiBold16: TextStyle.lerp(semiBold16, other.semiBold16, t)!,
      semiBold18: TextStyle.lerp(semiBold18, other.semiBold18, t)!,
      bold14: TextStyle.lerp(bold14, other.bold14, t)!,
      bold16: TextStyle.lerp(bold16, other.bold16, t)!,
      bold20: TextStyle.lerp(bold20, other.bold20, t)!,
      bold22: TextStyle.lerp(bold22, other.bold22, t)!,
      bold24: TextStyle.lerp(bold24, other.bold24, t)!,
      bold30: TextStyle.lerp(bold30, other.bold30, t)!,

    );
  }

  /// Return text theme for app from context.
  static AppTextTheme of(BuildContext context) {
    return Theme.of(context).extension<AppTextTheme>() ?? _throwThemeExceptionFromFunc(context);
  }

  /// @nodoc.
  @override
  ThemeExtension<AppTextTheme> copyWith({
    TextStyle? regular14,
    TextStyle? regular16,
    TextStyle? medium12,
    TextStyle? medium14,
    TextStyle? medium16,
    TextStyle? semiBold12,
    TextStyle? semiBold14,
    TextStyle? semiBold16,
    TextStyle? semiBold18,
    TextStyle? bold14,
    TextStyle? bold16,
    TextStyle? bold20,
    TextStyle? bold22,
    TextStyle? bold24,
    TextStyle? bold30,
  }) {
    return AppTextTheme._(
      regular14: regular14 ?? this.regular14,
      regular16: regular16 ?? this.regular16,
      medium12: medium14 ?? this.medium12,
      medium14: medium14 ?? this.medium14,
      medium16: medium16 ?? this.medium16,
      semiBold12: semiBold12 ?? this.semiBold12,
      semiBold14: semiBold14 ?? this.semiBold14,
      semiBold16: semiBold16 ?? this.semiBold16,
      semiBold18: semiBold18 ?? this.semiBold18,
      bold14: bold14 ?? this.bold14,
      bold16: bold16 ?? this.bold16,
      bold20: bold20 ?? this.bold20,
      bold22: bold22 ?? this.bold22,
      bold24: bold24 ?? this.bold24,
      bold30: bold30 ?? this.bold30,
    );
  }
}

Never _throwThemeExceptionFromFunc(BuildContext context) => throw Exception('$AppTextTheme не найдена в $context');
