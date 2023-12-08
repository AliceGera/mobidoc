import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/doctors/screen/doctors_screen_export.dart';
import 'package:flutter_template/features/home/screen/home_screen_export.dart';
import 'package:flutter_template/features/main/screens/main_screen/main_screen_export.dart';
import 'package:flutter_template/features/medical_card/screens/login_screen/login_screen_export.dart';
import 'package:flutter_template/features/medical_card/screens/medical_card_screen/medical_card_screen_export.dart';
import 'package:flutter_template/features/medical_card/screens/onboarding_screen/onboarding_screen_export.dart';
import 'package:flutter_template/features/navigation/domain/entity/login/login_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/main/main_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/onboarding/onboarding_routes.dart';
import 'package:flutter_template/features/services/screen/services_screen_export.dart';

part 'router.gr.dart';

/// When you add route with screen don't forget add imports of screen and screen_widget_model

@AutoRouterConfig(
  replaceInRouteName: 'ScreenWidget|Screen,Route',
)

/// Main point of the application navigation.
class AppRouter extends _$AppRouter {
  static final AppRouter _router = AppRouter._();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        mainRoutes,
        onboardingRoutes,
        loginRoutes,
      ];

  AppRouter._();

  /// Singleton instance of [AppRouter].
  factory AppRouter.instance() => _router;
}
