import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/main/screens/main_screen/main_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// Initialization screens (this can be a HomeScreen or SplashScreen for example).
@RoutePage(
  name: AppRouteNames.mainScreen,
)
class MainScreen extends ElementaryWidget<MainScreenWidgetModel> {
  /// Create an instance [MainScreen].
  const MainScreen({
    Key? key,
    WidgetModelFactory wmFactory = initScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(MainScreenWidgetModel wm) {
    return AutoTabsRouter.tabBar(
      routes: wm.routes,
      builder: (context, child, controller) {
        final tabsRouter = context.tabsRouter;
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: wm.navigationBarItems,
            unselectedItemColor: const Color(0xffDAD7E0),
            selectedItemColor: const Color(0xff007AFE),
            showUnselectedLabels: true,
          ),
        );
      },
    );
  }
}
