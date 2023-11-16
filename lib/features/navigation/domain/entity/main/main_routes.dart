import 'package:auto_route/auto_route.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_paths.dart';
import 'package:flutter_template/features/navigation/domain/entity/doctors/doctors_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/home/home_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/medical_card/medical_card_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/services/services_routes.dart';
import 'package:flutter_template/features/navigation/service/router.dart';

/// All routes for the temp feature.
final mainRoutes = AutoRoute(
  page: TempRouter.page,
  initial: true,
  path: AppRoutePaths.tempPath,
  children: [
    homeRoutes,
    servicesRoutes,
    medicalCardRoutes,
    doctorsRoutes,
  ],
);