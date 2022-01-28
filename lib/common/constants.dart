import 'package:flutter/material.dart';
import 'package:core/core.dart' show AppColors, AppTextStyle;

const String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';

// text theme
final kTextTheme = TextTheme(
  headline5: AppTextStyle.kHeading5,
  headline6: AppTextStyle.kHeading6,
  subtitle1: AppTextStyle.kSubtitle,
  bodyText2: AppTextStyle.kBodyText,
);

const kColorScheme = ColorScheme(
  primary: AppColors.kMikadoYellow,
  primaryVariant: AppColors.kMikadoYellow,
  secondary: AppColors.kPrussianBlue,
  secondaryVariant: AppColors.kPrussianBlue,
  surface: AppColors.kRichBlack,
  background: AppColors.kRichBlack,
  error: Colors.red,
  onPrimary: AppColors.kRichBlack,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);

const kDividerTheme = DividerThemeData(
  color: AppColors.kMikadoYellow,
);

enum SearchContext {
  tvSeries,
  movie,
}