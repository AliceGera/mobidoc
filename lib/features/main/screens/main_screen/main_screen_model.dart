import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/common/service/theme/theme_service.dart';
import 'package:flutter_template/features/main/screens/main_screen/main_screen.dart';

/// Model for [MainScreen].
class MainScreenModel extends ElementaryModel implements IMainScreenModel {
  final IThemeService _themeService;

  /// Create an instance [MainScreenModel].
  MainScreenModel(this._themeService);

  @override
  void switchTheme() {
    _themeService.switchTheme();
  }
}

/// Interface of [MainScreenModel].
abstract class IMainScreenModel extends ElementaryModel {
  /// Switch theme mode between light and dark.
  void switchTheme();
}
