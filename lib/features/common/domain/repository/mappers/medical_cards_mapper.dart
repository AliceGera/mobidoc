import 'package:flutter_template/api/data/medical_cards_response.dart';
import 'package:flutter_template/features/common/domain/data/medical_card/medical_cards_data.dart';
import 'package:flutter_template/features/common/domain/data/medical_card/medical_cards_member_data.dart';

/// Map [MedicalCardsResponse] to [MedicalCards]
MedicalCards mapResponseToMedicalCards(MedicalCardsResponse response) {
  return MedicalCards(
    member: response.member
        .map(
          (e) => MedicalCardsMember(
            id: e?.id ?? 0,
            name: e?.name ?? '',
            description: e?.description ?? '',
            number: e?.number ?? 0,
          ),
        )
        .toList(),
  );
}
