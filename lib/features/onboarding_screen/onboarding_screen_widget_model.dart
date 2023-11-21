// ignore_for_file: public_member_api_docs

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/medical_card/screens/medical_card_screen/medical_card_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/features/onboarding_screen/onboarding_screen.dart';
import 'package:flutter_template/features/onboarding_screen/onboarding_screen_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Factory for [OnboardingScreenWidgetModel].
OnboardingScreenWidgetModel onboardingScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final router = appDependencies.router;
  final model = OnboardingScreenModel();
  final sharedPreferences = appDependencies.sharedPreferences;
  return OnboardingScreenWidgetModel(
    model,
    sharedPreferences,
    router,
  );
}

/// Widget Model for [OnboardingScreen].
class OnboardingScreenWidgetModel extends WidgetModel<OnboardingScreen, OnboardingScreenModel> implements IOnboardingScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final SharedPreferences sharedPreferences;
  final AppRouter router;

  /// Create an instance [MedicalCardScreenModel].
  OnboardingScreenWidgetModel(
    super._model,
    this.sharedPreferences,
    this.router,
  );

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void openLogin() {
    router.push(LoginRouter());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> finishOnboarding() async {
    await sharedPreferences.setBool('onboardingFinished', true);
  }
}

/// Interface of [OnboardingScreenWidgetModel].
abstract class IOnboardingScreenWidgetModel extends IWidgetModel {
  Future<void> finishOnboarding();

  /// Navigate to onboarding screen.
  void openLogin();
}
