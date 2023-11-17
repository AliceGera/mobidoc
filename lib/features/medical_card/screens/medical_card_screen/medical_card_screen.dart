import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/medical_card/screens/medical_card_screen/medical_card_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// medical card screens.
@RoutePage(
  name: AppRouteNames.medicalCardScreen,
)
class MedicalCardScreen extends ElementaryWidget<IMedicalCardScreenWidgetModel> {
  /// Create an instance [MedicalCardScreen].
  const MedicalCardScreen({
    Key? key,
    WidgetModelFactory wmFactory = medicalCardScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IMedicalCardScreenWidgetModel wm) {
    return Scaffold(
      body: _Body(
        themeState: wm.themeState,
        openOnboarding: wm.openOnboarding,
        setThemeMode: wm.setThemeMode,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final ListenableState<ThemeMode> themeState;
  final void Function(ThemeMode?) setThemeMode;
  final VoidCallback openOnboarding;

  const _Body({
    required this.themeState,
    required this.setThemeMode,
    required this.openOnboarding,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Text('Medical Screen'),
              Card(
                child: ListTile(
                  onTap: openOnboarding,
                  title: const Text('To onboarding screen'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
