import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/common/domain/data/doctors/doctors_data.dart';
import 'package:flutter_template/features/common/service/doctors_service.dart';
import 'package:flutter_template/features/doctors/screen/doctors_screen.dart';

/// Model fol [DoctorsScreen].
class DoctorsScreenModel extends ElementaryModel {
  final DoctorsService _doctorsService;

  /// Create an instance [DoctorsScreenModel].
  DoctorsScreenModel(
      this._doctorsService,
      ) : super();

  Future<Doctors> getDoctors() async {
    try {
      final doctors = await _doctorsService.getDoctors();
      return doctors;
    } on Object {
      rethrow;
    }
  }
}
