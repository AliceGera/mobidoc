import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/medical_card/screens/login_screen/login_screen.dart';
import 'package:flutter_template/features/medical_card/screens/login_screen/login_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

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
  final router = appDependencies.router;
  return LoginScreenWidgetModel(model, router);
}

/// Widget Model for [LoginScreen].
class LoginScreenWidgetModel extends WidgetModel<LoginScreen, LoginScreenModel> implements ILoginScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  late final TextEditingController _textEmailController;
  final AppRouter router;
  final _themeState = StateNotifier<ThemeMode>();
  @override
  ListenableState<ThemeMode> get themeState => _themeState;

  /// Create an instance [LoginScreenModel].
  LoginScreenWidgetModel(
    super._model,
    this.router,
  );
  @override
  TextEditingController get textEmailController => _textEmailController;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _textEmailController = TextEditingController();
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
    router.pop();
  }

  @override
  void setThemeMode(ThemeMode? themeMode) {
    if (themeMode == null) return;
    model.setThemeMode(themeMode);
  }

  @override
  void openOnboarding() {
    router.push( OnboardingRouter());
  }

  @override
  void openLogin() {
    router.push( LoginRouter());
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
  /// Method to close the debug screens.
  void closeScreen() {}

  /// Set theme mode for app.
  void setThemeMode(ThemeMode? themeMode) {}

  /// Navigate to onboarding screen.
  void openOnboarding();

  /// Navigate to login screen.
  void openLogin();
}
