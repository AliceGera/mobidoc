import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/services/screen/services_screen.dart';
import 'package:flutter_template/features/services/screen/services_screen_model.dart';

/// Factory for [ServicesScreenWidgetModel].
ServicesScreenWidgetModel servicesScreenWmFactory(
  BuildContext context,
) {
  final model = ServicesScreenModel();
  return ServicesScreenWidgetModel(model);
}

/// Widget model for [ServicesScreen].
class ServicesScreenWidgetModel extends WidgetModel<ServicesScreen, ServicesScreenModel>
    with ThemeWMMixin
    implements IServicesScreenWidgetModel {
  /// Create an instance [ServicesScreenWidgetModel].
  ServicesScreenWidgetModel(super._model);
}

/// Interface of [ServicesScreenWidgetModel].
abstract class IServicesScreenWidgetModel extends IWidgetModel
    with ThemeIModelMixin {}
