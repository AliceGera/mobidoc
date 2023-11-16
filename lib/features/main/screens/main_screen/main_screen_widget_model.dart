import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/main/screens/main_screen/main_screen.dart';
import 'package:flutter_template/features/main/screens/main_screen/main_screen_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_paths.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

/// Factory for [TempScreenWidgetModel].
TempScreenWidgetModel initScreenWidgetModelFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = TempScreenModel(
    Environment.instance(),
    appScope.themeService,
  );

  return TempScreenWidgetModel(model);
}

/// Widget model for [TempScreen].
class TempScreenWidgetModel extends WidgetModel<TempScreen, ITempScreenModel>
    with ThemeWMMixin
    implements IDebugWidgetModel {
  final _defaultNavBarItems = [
    BottomNavigationBarItem(
      label: 'Главная',
      icon: SvgPicture.asset(SvgIcons.iconHome),
      activeIcon:SvgPicture.asset(SvgIcons.iconHomeSelected),
    ),
    BottomNavigationBarItem(
      label: 'Услуги',
      icon: SvgPicture.asset(SvgIcons.iconServices),
      activeIcon:SvgPicture.asset(SvgIcons.iconServicesSelected),
    ),
    BottomNavigationBarItem(
      label: 'Врачи',
      icon: SvgPicture.asset(SvgIcons.iconDoctors),
      activeIcon:SvgPicture.asset(SvgIcons.iconDoctorsSelected),
    ),
  ];

  final _debugNavBarItem =  BottomNavigationBarItem(
    label: 'Медкарта',
    activeIcon:SvgPicture.asset(SvgIcons.iconMedicalCardSelected),
    icon: SvgPicture.asset(SvgIcons.iconMedicalCard),
  );

  @override
  List<PageRouteInfo> get routes => _routes;

  @override
  List<BottomNavigationBarItem> get navigationBarItems => _navigationBarItems;

  List<PageRouteInfo> get _routes {
    final defaultRoutes = <PageRouteInfo>[HomeRouter(), ServicesRouter(),DoctorsRouter()];
    if (_isDebugMode) defaultRoutes.add(MedicalCardRouter());
    return defaultRoutes;
  }

  List<BottomNavigationBarItem> get _navigationBarItems {
    final navBarItems = [..._defaultNavBarItems];
    if (_isDebugMode) navBarItems.add(_debugNavBarItem);
    return navBarItems;
  }

  bool get _isDebugMode => model.isDebugMode;

  /// Create an instance [TempScreenWidgetModel].
  TempScreenWidgetModel(super._model);

  @override
  String appBarTitle(RouteData topRoute) => _appBarTitle(topRoute);

  @override
  void switchTheme() => model.switchTheme();

  String _appBarTitle(RouteData topRoute) {
    switch (topRoute.path) {
      case AppRoutePaths.medicalCardPath:
        return 'Главная';
      case AppRoutePaths.homePath:
        return 'Услуги';
      case AppRoutePaths.servicesPath:
        return 'Медкарта';
      case AppRoutePaths.doctorsPath:
        return 'Врачи';
      default:
        return '';
    }
  }
}

/// Interface of [TempScreenWidgetModel].
abstract class IDebugWidgetModel extends IWidgetModel with ThemeIModelMixin {
  /// Routes for [AutoTabsRouter.tabBar].
  List<PageRouteInfo<dynamic>> get routes;

  /// Items for [BottomNavigationBar].
  List<BottomNavigationBarItem> get navigationBarItems;

  /// Title for appbar, depends on current selected page.
  String appBarTitle(RouteData topRoute);

  /// Switch theme mode between light and dark.
  void switchTheme();
}
