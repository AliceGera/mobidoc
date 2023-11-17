import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/app_config.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/features/common/service/theme/theme_service.dart';
import 'package:flutter_template/features/medical_card/screens/medical_card_screen/medical_card_screen.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Model for [MedicalCardScreen].
class MedicalCardScreenModel extends ElementaryModel {
  /// Interface for handle error in business logic.
  final ErrorHandler errorHandler;

  /// Environment configuration.
  final Environment _environment;

  final IThemeService _themeService;

  /// Config change Notifier.
  late ValueNotifier<AppConfig> configNotifier;

  /// Theme mode change Notifier.
  late ValueNotifier<ThemeMode> currentThemeMode;

  /// Create an instance [MedicalCardScreenModel].
  MedicalCardScreenModel(
    this.errorHandler,
    this._environment,
    this._themeService,
  ) : super(errorHandler: errorHandler);

  @override
  void init() {
    configNotifier = ValueNotifier<AppConfig>(_environment.config);
    currentThemeMode = ValueNotifier<ThemeMode>(_themeService.currentThemeMode);
    _themeService.addListener(_updateTheme);
    _environment.addListener(_environmentChangedCallback);
  }

  @override
  void dispose() {
    _environment.removeListener(_environmentChangedCallback);
    _themeService.removeListener(_updateTheme);
  }

  /// Set theme mode for app.
  void setThemeMode(ThemeMode themeMode) {
    _themeService.updateThemeMode(themeMode);
  }

  void _environmentChangedCallback() {
    configNotifier.value = _environment.config;
  }

  void _updateTheme() {
    currentThemeMode.value = _themeService.currentThemeMode;
  }
}
