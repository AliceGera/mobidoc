import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/config/urls.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/medical_card/screens/medical_card_screen/medical_card_screen.dart';
import 'package:flutter_template/features/medical_card/screens/medical_card_screen/medical_card_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/persistence/storage/config_storage/config_storage_impl.dart';
import 'package:provider/provider.dart';
import 'package:surf_logger/surf_logger.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Factory for [MedicalCardScreenWidgetModel].
MedicalCardScreenWidgetModel medicalCardScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final configStorage =
      ConfigSettingsStorageImpl(appDependencies.sharedPreferences);

  final model = MedicalCardScreenModel(
    appDependencies.errorHandler,
    Environment.instance(),
    appDependencies.applicationRebuilder,
    configStorage,
    appDependencies.themeService,
  );
  final router = appDependencies.router;
  return MedicalCardScreenWidgetModel(model, router);
}

/// Widget Model for [MedicalCardScreen].
class MedicalCardScreenWidgetModel extends WidgetModel<MedicalCardScreen, MedicalCardScreenModel>
    implements IMedicalCardScreenWidgetModel {
  /// Empty string.
  static const String _emptyString = '';

  /// Class that coordinates navigation for the whole app.
  final AppRouter router;

  late final _textEditingController = TextEditingController(
    text: model.proxyUrl,
  );
  final _urlState = StateNotifier<UrlType>();
  final _themeState = StateNotifier<ThemeMode>();

  @override
  TextEditingController get proxyEditingController => _textEditingController;

  @override
  ListenableState<UrlType> get urlState => _urlState;

  @override
  ListenableState<ThemeMode> get themeState => _themeState;

  /// Current value url.
  late String _currentUrl;

  /// Proxy url.
  late String? _proxyUrl;

  /// Create an instance [MedicalCardScreenModel].
  MedicalCardScreenWidgetModel(
    super._model,
    this.router,
  );

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.configNotifier.addListener(_updateAppConfig);
    model.currentThemeMode.addListener(_updateThemeMode);
    _themeState.accept(model.currentThemeMode.value);
  }

  @override
  void dispose() {
    model.configNotifier.removeListener(_updateAppConfig);
    super.dispose();
  }

  @override
  void closeScreen() {
    router.pop();
  }

  @override
  void urlChange(UrlType? urlType) => _urlState.accept(urlType);

  @override
  void switchServer(UrlType urlType) {
    model.switchServer(urlType);
  }

  /// Change proxyUrl value.
  @override
  void setProxy() {
    model.setProxy(proxyEditingController.text);
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
  Future<void> saveExampleLog() async => _saveExampleLog();

  void _updateAppConfig() {
    final config = model.configNotifier.value;

    _currentUrl = config.url;
    _proxyUrl = config.proxyUrl;

    if (_currentUrl == Url.testUrl) {
      _urlState.accept(UrlType.test);
    } else if (_currentUrl == Url.prodUrl) {
      _urlState.accept(UrlType.prod);
    } else {
      _urlState.accept(UrlType.dev);
    }

    if (_proxyUrl != null && _proxyUrl!.isNotEmpty) {
      proxyEditingController
        ..text = _proxyUrl!
        ..selection = TextSelection.collapsed(
          offset: _proxyUrl!.length,
        );
    } else {
      proxyEditingController.text = _emptyString;
    }
  }

  void _updateThemeMode() {
    _themeState.accept(model.currentThemeMode.value);
  }

  void _saveExampleLog() {
    final error = Exception('Some exception');
    final st = StackTrace.fromString('stackTraceString');
    Logger.e(st.toString(), error);
  }
}

/// Interface of [MedicalCardScreenWidgetModel].
abstract class IMedicalCardScreenWidgetModel extends IWidgetModel {
  /// Text Editing Controller.
  TextEditingController get proxyEditingController;

  /// Listener current state [UrlType].
  ListenableState<UrlType> get urlState;

  /// Listener current state [ThemeMode].
  ListenableState<ThemeMode> get themeState;

  /// Method to close the debug screens.
  void closeScreen() {}

  /// Change url.
  void urlChange(UrlType? urlType) {}

  /// Switch server.
  void switchServer(UrlType urlType) {}

  /// Change proxyUrl value.
  void setProxy() {}

  /// Set theme mode for app.
  void setThemeMode(ThemeMode? themeMode) {}


  /// Method for save example log to log history file.
  void saveExampleLog();

  /// Navigate to ui kit screen.
  void openOnboarding();
}

/// Ury type.
enum UrlType {
  /// Test.
  test,

  /// Prod.
  prod,

  /// Dev.
  dev,
}
