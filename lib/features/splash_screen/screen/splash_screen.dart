// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:flutter_template/features/splash_screen/screen/splash_screen_widget_model.dart';

/// medical card screens.
@RoutePage(
  name: AppRouteNames.splashScreen,
)
class SplashScreen extends ElementaryWidget<ISplashWidgetModel> {
  const SplashScreen({
    Key? key,
    WidgetModelFactory wmFactory = splashWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISplashWidgetModel wm) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.darkBlue,
            AppColors.lightBlue,
          ],
        ),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.white,
        ),
      ),
    );
  }
}
