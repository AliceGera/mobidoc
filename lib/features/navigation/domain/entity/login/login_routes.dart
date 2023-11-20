import 'package:auto_route/auto_route.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_paths.dart';
import 'package:flutter_template/features/navigation/service/router.dart';

/// Routes of onboarding.
final loginRoutes = AutoRoute(
  page: LoginRouter.page,
  path: AppRoutePaths.loginPath,
);
