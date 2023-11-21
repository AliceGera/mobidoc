import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_paths.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/features/splash_screen/screen/splash_screen.dart';
import 'package:flutter_template/features/splash_screen/screen/splash_screen_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Factory for [SplashScreenWidgetModel].
SplashScreenWidgetModel splashWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final model = SplashScreenModel();

  return SplashScreenWidgetModel(
    model,
    appDependencies.router,
    appDependencies.sharedPreferences,
  );
}

/// Widget model for [SplashScreen].
class SplashScreenWidgetModel extends WidgetModel<SplashScreen, SplashScreenModel> with TickerProviderWidgetModelMixin implements ISplashWidgetModel {
  final AppRouter _appRouter;
  final SharedPreferences _prefs;

  /// Create an instance [SplashScreenWidgetModel].
  SplashScreenWidgetModel(
    super._model,
    this._appRouter,
    this._prefs,
  );

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    Future<void>.delayed(const Duration(seconds: 2)).whenComplete(() async {
      await _navigate();
    });
  }

  Future<void> _navigate() async {
    //await _prefs.setBool('onboardingFinished', false);
    final isOnboardingFinish = _prefs.getBool('onboardingFinished') ?? false;
    if (!isOnboardingFinish) {
      await _appRouter.replaceNamed(AppRoutePaths.onboardingPath);
    } else {
      final isRegistrationFinished= _prefs.getBool('registrationFinished') ?? false;
      if (isRegistrationFinished) {
        await _appRouter.replaceNamed(AppRoutePaths.mainPath);
      } else {
        await _appRouter.replaceNamed(AppRoutePaths.loginPath);
      }
    }
  }

}

/// Interface of [SplashScreenWidgetModel].
abstract class ISplashWidgetModel extends IWidgetModel {

}
