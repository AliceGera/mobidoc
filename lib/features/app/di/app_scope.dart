// ignore_for_file: public_member_api_docs

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/api/service/doctors_api.dart';
import 'package:flutter_template/api/service/medical_cards_api.dart';
import 'package:flutter_template/api/service/services_api.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/features/common/domain/repository/doctors_repository.dart';
import 'package:flutter_template/features/common/domain/repository/medical_cards_repository.dart';
import 'package:flutter_template/features/common/domain/repository/services_repository.dart';
import 'package:flutter_template/features/common/service/doctors_service.dart';
import 'package:flutter_template/features/common/service/medical_cards_service.dart';
import 'package:flutter_template/features/common/service/services_service.dart';
import 'package:flutter_template/features/common/service/theme/theme_service.dart';
import 'package:flutter_template/features/common/service/theme/theme_service_impl.dart';
import 'package:flutter_template/features/common/utils/analytics/amplitude/amplitude_analytic_tracker.dart';
import 'package:flutter_template/features/common/utils/analytics/firebase/firebase_analytic_tracker.dart';
import 'package:flutter_template/features/common/utils/analytics/mock/mock_amplitude_analytics.dart';
import 'package:flutter_template/features/common/utils/analytics/mock/mock_firebase_analytics.dart';
import 'package:flutter_template/features/common/utils/analytics/service/analytics_service.dart';
import 'package:flutter_template/features/common/utils/analytics/service/analytics_service_impl.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/persistence/storage/theme_storage/theme_storage.dart';
import 'package:flutter_template/persistence/storage/theme_storage/theme_storage_impl.dart';
import 'package:flutter_template/util/default_error_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Scope of dependencies which need through all app's life.
class AppScope implements IAppScope {
  static const _themeByDefault = ThemeMode.system;

  final SharedPreferences _sharedPreferences;

  late final Dio _dio;
  late final ErrorHandler _errorHandler;
  late final AppRouter _router;
  late final IThemeService _themeService;
  late final IAnalyticsService _analyticsService;
  late final ServicesService _servicesService;
  late final DoctorsService _doctorsService;
  late final MedicalCardsService _medicalCardsService;
  late final ServicesRepository _servicesRepository;
  late final DoctorsRepository _doctorsRepository;
  late final MedicalCardsRepository _medicalCardsRepository;
  late final ServicesApi _servicesApi;
  late final DoctorsApi _doctorsApi;
  late final MedicalCardsApi _medicalCardsApi;
  @override
  late VoidCallback applicationRebuilder;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  AppRouter get router => _router;

  @override
  IThemeService get themeService => _themeService;

  @override
  SharedPreferences get sharedPreferences => _sharedPreferences;

  @override
  IAnalyticsService get analyticsService => _analyticsService;

  late IThemeModeStorage _themeModeStorage;

  @override
  ServicesService get servicesService => _servicesService;

  @override
  DoctorsService get doctorsService => _doctorsService;

  @override
  MedicalCardsService get  medicalCardsService => _medicalCardsService;
  /// Create an instance [AppScope].
  AppScope(this._sharedPreferences) {
    /// List interceptor. Fill in as needed.
    final additionalInterceptors = <Interceptor>[];

    _dio = _initDio(additionalInterceptors);
    _errorHandler = DefaultErrorHandler();
    _router = AppRouter.instance();
    _themeModeStorage = ThemeModeStorageImpl(_sharedPreferences);
    _analyticsService = AnalyticsServiceImpl([
      // TODO(init): can be removed MockFirebaseAnalytics and MockAmplitudeAnalytics, added for demo analytics track
      FirebaseAnalyticTracker(MockFirebaseAnalytics()),
      AmplitudeAnalyticTracker(MockAmplitudeAnalytics()),
    ]);
    _servicesApi = ServicesApi(dio);
    _doctorsApi = DoctorsApi(dio);
    _medicalCardsApi = MedicalCardsApi(dio);
    _servicesService = _initServicesService();
    _doctorsService = _initDoctorsService();
    _medicalCardsService= _initMedicalCardsService();
  }

  @override
  Future<void> initTheme() async {
    final theme =
        await ThemeModeStorageImpl(_sharedPreferences).getThemeMode() ??
            _themeByDefault;
    _themeService = ThemeServiceImpl(theme);
    _themeService.addListener(_onThemeModeChanged);
  }

  Dio _initDio(Iterable<Interceptor> additionalInterceptors) {
    const timeout = Duration(seconds: 30);

    final dio = Dio();

    dio.options
      ..baseUrl = Environment.instance().config.url
      ..connectTimeout = timeout
      ..receiveTimeout = timeout
      ..sendTimeout = timeout;

    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
      final proxyUrl = Environment.instance().config.proxyUrl;
      if (proxyUrl != null && proxyUrl.isNotEmpty) {
        client
          ..findProxy = (uri) {
            return 'PROXY $proxyUrl';
          }
          ..badCertificateCallback = (_, __, ___) {
            return true;
          };
      }

      return client;
    };

    dio.interceptors.addAll(additionalInterceptors);

    if (Environment.instance().isDebug) {
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }

    return dio;
  }

  Future<void> _onThemeModeChanged() async {
    await _themeModeStorage.saveThemeMode(mode: _themeService.currentThemeMode);
  }
  ServicesService _initServicesService() {
    _servicesRepository = ServicesRepository(_servicesApi);
    return ServicesService(_servicesRepository);
  }
  DoctorsService _initDoctorsService() {
    _doctorsRepository = DoctorsRepository(_doctorsApi);
    return  DoctorsService(_doctorsRepository);
  }

  MedicalCardsService _initMedicalCardsService() {
    _medicalCardsRepository = MedicalCardsRepository(_medicalCardsApi);
    return  MedicalCardsService(_medicalCardsRepository);
  }
}

/// App dependencies.
abstract class IAppScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Callback to rebuild the whole application.
  VoidCallback get applicationRebuilder;

  /// Class that coordinates navigation for the whole app.
  AppRouter get router;

  /// A service that stores and retrieves app theme mode.
  IThemeService get themeService;

  /// Init theme service with theme from storage or default value.
  Future<void> initTheme();

  /// Shared preferences.
  SharedPreferences get sharedPreferences;

  /// Analytics sending service
  IAnalyticsService get analyticsService;

  ServicesService get servicesService;

  DoctorsService get doctorsService;

  MedicalCardsService get medicalCardsService;
}
