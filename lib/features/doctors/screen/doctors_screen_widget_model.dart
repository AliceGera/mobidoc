import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/doctors/screen/doctors_screen.dart';
import 'package:flutter_template/features/doctors/screen/doctors_screen_model.dart';

/// Factory for [DoctorsScreenWidgetModel].
DoctorsScreenWidgetModel doctorsScreenWmFactory(
  BuildContext context,
) {
  final model = DoctorsScreenModel();
  return DoctorsScreenWidgetModel(model);
}

/// Widget model for [DoctorsScreen].
class DoctorsScreenWidgetModel extends WidgetModel<DoctorsScreen, DoctorsScreenModel>
    with ThemeWMMixin
    implements IDoctorsScreenWidgetModel {
  /// Create an instance [DoctorsScreenWidgetModel].
  DoctorsScreenWidgetModel(super._model);
}

/// Interface of [DoctorsScreenWidgetModel].
abstract class IDoctorsScreenWidgetModel extends IWidgetModel
    with ThemeIModelMixin {}
