// ignore_for_file: public_member_api_docs

import 'package:flutter_template/features/common/domain/data/medical_card/medical_cards_member_data.dart';

class MedicalCards {
  final List<MedicalCardsMember> member;

  // ignore: public_member_api_docs
  MedicalCards({
    required this.member,
  });

  MedicalCards copyWith({
    List<MedicalCardsMember>? member,
  }) {
    return MedicalCards(
      member: member ?? this.member,
    );
  }
  static MedicalCards init() => MedicalCards(
    member: [],
  );

}
