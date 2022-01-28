import 'dart:ui';

class AppColors {
  // no constructor.
  AppColors._();

  static const Color kRichBlack = Color(0xFF000814);
  static const Color kOxfordBlue = Color(0xFF001D3D);
  static const Color kPrussianBlue = Color(0xFF003566);
  static const Color kMikadoYellow = Color(0xFFffc300);
  static const Color kDavysGrey = Color(0xFF4B5358);
  static const Color kGrey = Color(0xFF303030);
  static final Color kGrey30 = kGrey.withAlpha(255 - (255 * 0.3).ceil()); // 30% transparency
  static final Color kGrey70 = kGrey.withAlpha(255 - (255 * 0.7).ceil()); // 70% transparency
}