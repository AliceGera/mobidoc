import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/doctors/screen/doctors_screen_wm.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// Main widget for DoctorsScreen feature.
@RoutePage(
  name: AppRouteNames.doctorsScreen,
)
class DoctorsScreen extends ElementaryWidget<IDoctorsScreenWidgetModel> {
  /// Create an instance [DoctorsScreen].
  const DoctorsScreen({
    Key? key,
    WidgetModelFactory wmFactory = doctorsScreenWmFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IDoctorsScreenWidgetModel wm) {
    return ColoredBox(
      color: wm.colorScheme.background,
      child: const Center(
        child: Text('Doctors Screen'),
      ),
    );
  }
}
