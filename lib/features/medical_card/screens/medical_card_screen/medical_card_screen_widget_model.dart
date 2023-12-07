// ignore_for_file: public_member_api_docs
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/medical_card/medical_cards_data.dart';
import 'package:flutter_template/features/common/domain/data/medical_card/medical_cards_member_data.dart';
import 'package:flutter_template/features/medical_card/screens/medical_card_screen/medical_card_screen.dart';
import 'package:flutter_template/features/medical_card/screens/medical_card_screen/medical_card_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:union_state/union_state.dart';

// ignore_for_file: avoid_positional_boolean_parameters
typedef OpenNextScreen = void Function(String name, String description);

/// Factory for [MedicalCardScreenWidgetModel].
MedicalCardScreenWidgetModel medicalCardScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final sharedPreferences = appDependencies.sharedPreferences;
  Barcode? result;
  QRViewController? controller;
  final model = MedicalCardScreenModel(
    appDependencies.medicalCardsService,
    appDependencies.errorHandler,
    Environment.instance(),
    result,
    controller,
    appDependencies.themeService,
  );
  final router = appDependencies.router;

  return MedicalCardScreenWidgetModel(
    sharedPreferences,
    model,
    router,
  );
}

/// Widget Model for [MedicalCardScreen].
class MedicalCardScreenWidgetModel extends WidgetModel<MedicalCardScreen, MedicalCardScreenModel> implements IMedicalCardScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final SharedPreferences sharedPreferences;
  final AppRouter router;
  final _themeState = StateNotifier<ThemeMode>();
  BuildContext? bottomSheetContext;
  QRViewController? _controller;
  late final ValueNotifier<QRViewController?> _qrControllerValue;
  final _medicalCardsState = UnionStateNotifier<MedicalCards>(MedicalCards.init());
  bool isBarcodeChecking = false;
  List<String> _qrCodeList = [];
  late final StateNotifier<bool> _isFindQr;
  late final StateNotifier<bool> _isShow;
  late final StateNotifier<bool> _isFirstTime;

  @override
  ListenableState<ThemeMode> get themeState => _themeState;

  /// Create an instance [MedicalCardScreenModel].
  MedicalCardScreenWidgetModel(
    this.sharedPreferences,
    super._model,
    this.router,
  );

  @override
  ListenableState<bool> get isFindQr => _isFindQr;

  @override
  ListenableState<bool> get isShow => _isShow;

  @override
  ListenableState<bool> get isFirstTime => _isFirstTime;

  @override
  QRViewController? get controller => _controller;

  @override
  ValueNotifier<QRViewController?> get qrControllerValue => _qrControllerValue;

  @override
  void initWidgetModel() {
    _qrCodeList = sharedPreferences.getStringList('QRCodeList') ?? [];
    _getAllMedicalCards(null);
    super.initWidgetModel();
    _isFindQr = StateNotifier<bool>(initValue: true);
    _isShow = StateNotifier<bool>(initValue: false);
    _isFirstTime = StateNotifier<bool>(initValue: true);
    _qrControllerValue = ValueNotifier(null);
    _controller = controller;
    model.currentThemeMode.addListener(_updateThemeMode);
    _themeState.accept(model.currentThemeMode.value);
  }

  Future<void> _getAllMedicalCards(String? result) async {
    _medicalCardsState.loading();
    var isContainQR = false;
    try {
      final medicalCards = await model.getMedicalCards();
      if (result != null) {
        _qrCodeList.add(result);
        _qrCodeList.toSet().toList();
        isContainQR = medicalCards.member.where((e) => e.number.toString() == result).toList().isNotEmpty;
        if (isContainQR) {
          await addQRCodeList();
        }
        _isFindQr.accept(isContainQR);
      }

      final members = <MedicalCardsMember>[];
      for (var i = 0; i < medicalCards.member.length; i++) {
        if (_qrCodeList.contains(medicalCards.member[i].number.toString())) {
          members.add(medicalCards.member[i]);
        }
      }
      _medicalCardsState.content(MedicalCards(member: members));

      if (result == null) {
        isBarcodeChecking = false;
      } else {
        _isShow.accept(true);
      }
      await Future.delayed(const Duration(seconds: 3));
      if (bottomSheetContext != null && isContainQR) {
        Navigator.of(bottomSheetContext!).pop();
        await Future.delayed(const Duration(seconds: 1));
        isBarcodeChecking = false;
        _isShow.accept(false);
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      //_isShow.accept(true);
      _medicalCardsState.failure();
      isBarcodeChecking = false;
    }
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
  void someMethod() {
    isBarcodeChecking = false;
    _isShow.accept(false);
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
  void openNextScreen(String name, String description) {
    router.push(InfoAboutMedicalCardRouter(name: name, description: description));
  }

  @override
  void onQRViewCreated(QRViewController controller) {
    _controller = controller;
    _controller?.scannedDataStream.listen(
      (scanData) {
        if (!isBarcodeChecking) {
          isBarcodeChecking = true;
          _getAllMedicalCards(scanData.code.toString());
        }
      },
    );
  }

  @override
  void onShowModalBottomSheet(BuildContext context) {
    bottomSheetContext = context;
  }

  @override
  UnionStateNotifier<MedicalCards> get medicalCardsState => _medicalCardsState;

  List<String> get qrCodeList => _qrCodeList;

  @override
  Future<void> addQRCodeList() async {
    await sharedPreferences.setStringList('QRCodeList', _qrCodeList);
  }
}

/// Interface of [MedicalCardScreenWidgetModel].
abstract class IMedicalCardScreenWidgetModel extends IWidgetModel {
  Future<void> addQRCodeList();

  UnionStateNotifier<MedicalCards> get medicalCardsState;

  /// Listener current state [ThemeMode].
  ListenableState<ThemeMode> get themeState;

  ListenableState<bool> get isFindQr;

  ListenableState<bool> get isShow;

  ListenableState<bool> get isFirstTime;

  /// Method to close the debug screens.
  void closeScreen() {}

  /// Set theme mode for app.
  void setThemeMode(ThemeMode? themeMode) {}

  /// Navigate to info about medical card screen.
  void openNextScreen(String name, String description);

  void onQRViewCreated(QRViewController controller);

  void onShowModalBottomSheet(BuildContext context);

  QRViewController? get controller;

  ValueNotifier<QRViewController?> get qrControllerValue;

  void someMethod();
}
