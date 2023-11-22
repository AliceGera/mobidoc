// ignore_for_file: public_member_api_docs, non_constant_identifier_names

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/services_data.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/common/service/services_service.dart';
import 'package:flutter_template/features/services/screen/services_screen.dart';
import 'package:flutter_template/features/services/screen/services_screen_model.dart';
import 'package:provider/provider.dart';

/// Factory for [ServicesScreenWidgetModel].
ServicesScreenWidgetModel servicesScreenWmFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final model = ServicesScreenModel(
    appDependencies.servicesService,
  );
  final servicesService = appDependencies.servicesService;
  return ServicesScreenWidgetModel(
    model,
    servicesService,
  );
}

/// Widget model for [ServicesScreen].
class ServicesScreenWidgetModel extends WidgetModel<ServicesScreen, ServicesScreenModel> with ThemeWMMixin implements IServicesScreenWidgetModel {
  /// Create an instance [ServicesScreenWidgetModel].

  final ServicesService _servicesService;
  final _servicesState = EntityStateNotifier<Services>();
  late final Services services;
  ServicesScreenWidgetModel(
    super._model,
    this._servicesService,
  );
  @override
  void initWidgetModel() {
    _getAllServices();
    super.initWidgetModel();
  }
  Future<void> _getAllServices() async {
     services = await model.getServices();
  }
  @override
  ServicesService get servicesService => _servicesService;

  @override
  ListenableState<EntityState<Services>> get ServicesState => _servicesState;
}

/// Interface of [ServicesScreenWidgetModel].
abstract class IServicesScreenWidgetModel extends IWidgetModel with ThemeIModelMixin {
  ServicesService get servicesService;
  ListenableState<EntityState<Services>> get ServicesState;
}