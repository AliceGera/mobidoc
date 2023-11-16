import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:flutter_template/features/services/screen/services_screen_wm.dart';

/// Main widget for ServicesScreen feature.
@RoutePage(
  name: AppRouteNames.servicesScreen,
)
class ServicesScreen extends ElementaryWidget<IServicesScreenWidgetModel> {
  /// Create an instance [ServicesScreen].
  const ServicesScreen({
    Key? key,
    WidgetModelFactory wmFactory = servicesScreenWmFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IServicesScreenWidgetModel wm) {
    return ColoredBox(
      color: wm.colorScheme.background,
      child: const Center(
        child: Text('Services Screen'),
      ),
    );
  }
}
