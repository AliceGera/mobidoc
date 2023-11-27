// ignore_for_file: public_member_api_docs

import 'package:flutter_template/api/service/doctors_api.dart';
import 'package:flutter_template/features/common/domain/data/doctors/doctors_data.dart';
import 'package:flutter_template/features/common/domain/repository/mappers/doctors_mapper.dart';


class DoctorsRepository {
  late final DoctorsApi _apiClient;

  DoctorsRepository(this._apiClient);

  Future<Doctors> getDoctors() async {
    final some = await _apiClient.getDoctors();
    return mapResponseToDoctors(some);
  }
}
