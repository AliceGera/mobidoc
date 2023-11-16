import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/urls.dart';
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
        urlState: wm.urlState,
        themeState: wm.themeState,
        urlChanged: wm.urlChange,
        switchServer: wm.switchServer,
        setProxy: wm.setProxy,
        openUiKit: wm.openOnboarding,
        saveExampleLog: wm.saveExampleLog,
        proxyController: wm.proxyEditingController,
        setThemeMode: wm.setThemeMode,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final ListenableState<UrlType> urlState;
  final ListenableState<ThemeMode> themeState;
  final void Function(UrlType?) urlChanged;
  final void Function(UrlType) switchServer;
  final void Function(ThemeMode?) setThemeMode;
  final Function() setProxy;
  final VoidCallback openUiKit;
  final VoidCallback saveExampleLog;
  final TextEditingController proxyController;

  const _Body({
    required this.urlState,
    required this.themeState,
    required this.urlChanged,
    required this.switchServer,
    required this.setThemeMode,
    required this.setProxy,
    required this.openUiKit,
    required this.saveExampleLog,
    required this.proxyController,
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
                  onTap: openUiKit,
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
