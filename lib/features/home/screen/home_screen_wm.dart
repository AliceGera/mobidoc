import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/common/utils/analytics/event/common/track_analytics_example.dart';
import 'package:flutter_template/features/common/utils/analytics/service/analytics_service.dart';
import 'package:flutter_template/features/home/screen/home_screen.dart';
import 'package:flutter_template/features/home/screen/home_screen_model.dart';
import 'package:flutter_template/l10n/app_localizations_x.dart';
import 'package:provider/provider.dart';

/// Factory for [DashScreenWidgetModel].
DashScreenWidgetModel homeScreenWmFactory(
  BuildContext context,
) {
  final scope = context.read<IAppScope>();
  final model = DashScreenModel();

  return DashScreenWidgetModel(
    model: model,
    analyticsService: scope.analyticsService,
  );
}

/// Widget model for [HomeScreen].
class DashScreenWidgetModel extends WidgetModel<HomeScreen, DashScreenModel>
    with ThemeWMMixin
    implements IDashScreenWidgetModel {
  final IAnalyticsService _analyticsService;

  @override
  AppLocalizations get l10n => context.l10n;

  /// Create an instance [DashScreenWidgetModel].
  DashScreenWidgetModel({
    required DashScreenModel model,
    required IAnalyticsService analyticsService,
  })  : _analyticsService = analyticsService,
        super(model);

  @override
  void trackAnalyticsExample() {
    _analyticsService.trackEvent(const TrackAnalyticsExampleEvent());
  }
}

/// Interface of [IDashScreenWidgetModel].
abstract class IDashScreenWidgetModel extends IWidgetModel
    with ThemeIModelMixin {
  /// Localization strings.
  AppLocalizations get l10n;

  /// Sending an analytics event
  void trackAnalyticsExample();
}
