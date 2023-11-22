import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/medical_card/screens/medical_card_screen/medical_card_screen.dart';
import 'package:flutter_template/features/medical_card/screens/medical_card_screen/medical_card_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Factory for [MedicalCardScreenWidgetModel].
MedicalCardScreenWidgetModel medicalCardScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();

  final model = MedicalCardScreenModel(
    appDependencies.errorHandler,
    Environment.instance(),
    appDependencies.themeService,
  );
  final router = appDependencies.router;
  return MedicalCardScreenWidgetModel(model, router);
}

/// Widget Model for [MedicalCardScreen].
class MedicalCardScreenWidgetModel extends WidgetModel<MedicalCardScreen, MedicalCardScreenModel> implements IMedicalCardScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final AppRouter router;
  final _themeState = StateNotifier<ThemeMode>();
  @override
  ListenableState<ThemeMode> get themeState => _themeState;

  /// Create an instance [MedicalCardScreenModel].
  MedicalCardScreenWidgetModel(
    super._model,
    this.router,
  );

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.currentThemeMode.addListener(_updateThemeMode);
    _themeState.accept(model.currentThemeMode.value);
  }

  @override
  void dispose() {
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
    router.push(const OnboardingRouter());
  }

  @override
  void openLogin() {
    router.push(LoginRouter());
  }
  void _updateThemeMode() {
    _themeState.accept(model.currentThemeMode.value);
  }
}

/// Interface of [MedicalCardScreenWidgetModel].
abstract class IMedicalCardScreenWidgetModel extends IWidgetModel {
  /// Listener current state [ThemeMode].
  ListenableState<ThemeMode> get themeState;

  /// Method to close the debug screens.
  void closeScreen() {}

  /// Set theme mode for app.
  void setThemeMode(ThemeMode? themeMode) {}

  /// Navigate to onboarding screen.
  void openOnboarding();

  /// Navigate to login screen.
  void openLogin();
}
