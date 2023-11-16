import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/home/screen/home_screen_wm.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// Main widget for HomeScreen feature.
@RoutePage(
  name: AppRouteNames.homeScreen,
)
class HomeScreen extends ElementaryWidget<IHomeScreenWidgetModel> {
  /// Create an instance [HomeScreen].
  const HomeScreen({
    Key? key,
    WidgetModelFactory wmFactory = homeScreenWmFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IHomeScreenWidgetModel wm) {
    return  ColoredBox(
      color: wm.colorScheme.background,
      child: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}

