// ignore_for_file: public_member_api_docs

import 'package:flutter_template/features/common/domain/data/doctors/doctors_member_data.dart';

class Doctors {
  final List<DoctorMember> member;

  // ignore: public_member_api_docs
  Doctors({
    required this.member,
  });

  Doctors copyWith({
    List<DoctorMember>? member,
  }) {
    return Doctors(
      member: member ?? this.member,
    );
  }
}
