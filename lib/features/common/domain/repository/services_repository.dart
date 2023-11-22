// ignore_for_file: public_member_api_docs

import 'package:flutter_template/api/service/services_api.dart';
import 'package:flutter_template/features/common/domain/data/services_data.dart';

import 'package:flutter_template/features/common/domain/repository/mappers/services_mapper.dart';

class ServicesRepository {
  late final ServicesApi _apiClient;

  ServicesRepository(this._apiClient);

  Future<Services> getServices() async {
    return _apiClient.getServices().then(mapResponseToServices);
  }
}
