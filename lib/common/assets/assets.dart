import 'flares.dart';
import 'fonts.dart';
import 'images.dart';
import 'lang.dart';

abstract class Assets {
  const Assets();

  static const AppLanguages lang = AppLanguages();
  static const AppFlares flares = AppFlares();
  static const AppImages images = AppImages();
  static const AppFonts fonts = AppFonts();
}
