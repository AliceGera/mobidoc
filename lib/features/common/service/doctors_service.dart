// ignore_for_file: public_member_api_docs

import 'package:flutter_template/features/common/domain/data/doctors/doctors_data.dart';

import 'package:flutter_template/features/common/domain/repository/doctors_repository.dart';

class DoctorsService {
  final DoctorsRepository _doctorsRepository;
  DoctorsService(this._doctorsRepository);

  Future<Doctors> getDoctors() async {
    return _doctorsRepository.getDoctors();
  }
}
