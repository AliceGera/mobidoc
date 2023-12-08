// ignore_for_file: public_member_api_docs

import 'package:flutter_template/features/common/domain/data/services_data.dart';

import 'package:flutter_template/features/common/domain/repository/services_repository.dart';

class ServicesService {
  final ServicesRepository _servicesRepository;
  ServicesService(this._servicesRepository);

  Future<Services> getServices() async {
    return _servicesRepository.getServices();
  }
}
