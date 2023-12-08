// ignore_for_file: public_member_api_docs

import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/common/domain/data/services/services_data.dart';
import 'package:flutter_template/features/common/service/services_service.dart';
import 'package:flutter_template/features/services/screen/services_screen.dart';

/// Model fol [ServicesScreen].
class ServicesScreenModel extends ElementaryModel {
  final ServicesService _servicesService;

  /// Create an instance [ServicesScreenModel].
  ServicesScreenModel(
    this._servicesService,
  ) : super();

  Future<Services> getServices() async {
    try {
      final services = await _servicesService.getServices();
      return services;
    } on Object {
      rethrow;
    }
  }
}
