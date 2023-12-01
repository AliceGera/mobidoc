// ignore_for_file: public_member_api_docs
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/medical_card/screens/medical_card_screen/medical_card_screen.dart';
import 'package:flutter_template/features/medical_card/screens/medical_card_screen/medical_card_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Factory for [MedicalCardScreenWidgetModel].
MedicalCardScreenWidgetModel medicalCardScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  Barcode? result;
  QRViewController? controller;
  final model = MedicalCardScreenModel(
    appDependencies.errorHandler,
    Environment.instance(),
    result,
    controller,
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
  Barcode? _result;
  QRViewController? _controller;
  late final ValueNotifier<QRViewController?> _qrControllerValue;

  @override
  ListenableState<ThemeMode> get themeState => _themeState;

  /// Create an instance [MedicalCardScreenModel].
  MedicalCardScreenWidgetModel(
    super._model,
    this.router,
  );

  @override
  QRViewController? get controller => _controller;

  @override
  Barcode? get result => _result;

  @override
  ValueNotifier<QRViewController?> get qrControllerValue => _qrControllerValue;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _qrControllerValue = ValueNotifier(null);
    _controller = controller;
    model.currentThemeMode.addListener(_updateThemeMode);
    _themeState.accept(model.currentThemeMode.value);
  }

  @override
  void dispose() {
    _controller?.dispose();
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

  void _updateThemeMode() {
    _themeState.accept(model.currentThemeMode.value);
  }

  @override
  void openNextScreen() {
    router.push(InfoAboutMedicalCardRouter());
  }

  @override
  void onQRViewCreated(QRViewController controller) {
    _controller = controller;
    _controller?.scannedDataStream.listen(
      (scanData) {
        _result = scanData;
      },
    );
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

  /// Navigate to info about medical card screen.
  void openNextScreen();

  void onQRViewCreated(QRViewController controller);

  QRViewController? get controller;

  Barcode? get result;

  ValueNotifier<QRViewController?> get qrControllerValue;
}
