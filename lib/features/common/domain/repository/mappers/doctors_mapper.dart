import 'package:flutter_template/api/data/doctors_response.dart';
import 'package:flutter_template/features/common/domain/data/doctors/doctors_data.dart';

import 'package:flutter_template/features/common/domain/data/doctors/doctors_member_data.dart';

/// Map [DoctorsResponse] to [Doctors]
Doctors mapResponseToDoctors(DoctorsResponse response) {
  return Doctors(
    member: response.member
        .map(
          (e) => DoctorMember(
            id: e?.id ?? 0,
            name: e?.name ?? '',
            bio: e?.bio ?? '',
            speciality: e?.speciality ?? '',
          ),
        )
        .toList(),
  );
}
