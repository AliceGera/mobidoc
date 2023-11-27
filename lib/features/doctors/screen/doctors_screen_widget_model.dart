// ignore_for_file: public_member_api_docs

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/doctors/doctors_data.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/doctors/screen/doctors_screen.dart';
import 'package:flutter_template/features/doctors/screen/doctors_screen_model.dart';
import 'package:provider/provider.dart';

/// Factory for [DoctorsScreenWidgetModel].
DoctorsScreenWidgetModel doctorsScreenWmFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final model = DoctorsScreenModel( appDependencies.doctorsService);
  return DoctorsScreenWidgetModel(model);
}

/// Widget model for [DoctorsScreen].
class DoctorsScreenWidgetModel extends WidgetModel<DoctorsScreen, DoctorsScreenModel>
    with ThemeWMMixin
    implements IDoctorsScreenWidgetModel {
  /// Create an instance [DoctorsScreenWidgetModel].
  DoctorsScreenWidgetModel(super._model);

  final _doctorsState = EntityStateNotifier<Doctors>();
  late final Doctors doctors;
  @override
  void initWidgetModel() {
    _getAllDoctors();
    super.initWidgetModel();
  }

  Future<void> _getAllDoctors() async {
    _doctorsState.loading();
    try {
      doctors = await model.getDoctors();
      _doctorsState.accept(EntityState.content(doctors));
    } catch (_) {
      _doctorsState.error();
    }
  }
  @override
  ListenableState<EntityState<Doctors>> get DoctorsState => _doctorsState;

}

/// Interface of [DoctorsScreenWidgetModel].
abstract class IDoctorsScreenWidgetModel extends IWidgetModel
    with ThemeIModelMixin {
  ListenableState<EntityState<Doctors>> get DoctorsState;
}
