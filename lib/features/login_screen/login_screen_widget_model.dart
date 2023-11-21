// ignore_for_file: public_member_api_docs, type_annotate_public_apis

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/login_screen/login_screen.dart';
import 'package:flutter_template/features/login_screen/login_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Factory for [LoginScreenWidgetModel].
LoginScreenWidgetModel loginScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();

  final model = LoginScreenModel(
    appDependencies.errorHandler,
    Environment.instance(),
    appDependencies.themeService,
  );

  return LoginScreenWidgetModel(
    model,
    appDependencies.router,
    appDependencies.sharedPreferences,
  );
}

/// Widget Model for [LoginScreen].
class LoginScreenWidgetModel extends WidgetModel<LoginScreen, LoginScreenModel> implements ILoginScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  late final TextEditingController _textEmailController;
  late final TextEditingController _textPasswordController;

  final AppRouter _appRouter;
  final SharedPreferences _prefs;
  final _themeState = StateNotifier<ThemeMode>();

  @override
  ListenableState<ThemeMode> get themeState => _themeState;

  /// Create an instance [LoginScreenModel].
  LoginScreenWidgetModel(
    super._model,
    this._appRouter,
    this._prefs,
    );

  @override
  TextEditingController get textEmailController => _textEmailController;

  @override
  TextEditingController get textPasswordController => _textPasswordController;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _textEmailController = TextEditingController();
    _textPasswordController = TextEditingController();
    model.currentThemeMode.addListener(_updateThemeMode);
    _themeState.accept(model.currentThemeMode.value);
  }

  @override
  void dispose() {
    TextEditingController();
    super.dispose();
  }

  @override
  void closeScreen() {
    _appRouter.pop();
  }

  @override
  void setThemeMode(ThemeMode? themeMode) {
    if (themeMode == null) return;
    model.setThemeMode(themeMode);
  }

  @override
  void openNextScreen() {
    if (_textEmailController.text == 'cats@gmail.com' && _textPasswordController.text == '1234') {
      _appRouter.push(MainRouter());
    }
  }

  void _updateThemeMode() {
    _themeState.accept(model.currentThemeMode.value);
  }
}

/// Interface of [LoginScreenWidgetModel].
abstract class ILoginScreenWidgetModel extends IWidgetModel {
  /// Listener current state [ThemeMode].
  ListenableState<ThemeMode> get themeState;

  TextEditingController get textEmailController;

  TextEditingController get textPasswordController;

  /// Method to close the debug screens.
  void closeScreen() {}

  /// Set theme mode for app.
  void setThemeMode(ThemeMode? themeMode) {}

  /// Navigate to onboarding screen.
  void openNextScreen();
}
