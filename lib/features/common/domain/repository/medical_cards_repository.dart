// ignore_for_file: public_member_api_docs


import 'package:flutter_template/api/service/medical_cards_api.dart';
import 'package:flutter_template/features/common/domain/data/medical_card/medical_cards_data.dart';
import 'package:flutter_template/features/common/domain/repository/mappers/medical_cards_mapper.dart';


class MedicalCardsRepository {
  late final MedicalCardsApi _apiClient;

  MedicalCardsRepository(this._apiClient);

  Future<MedicalCards> getMedicalCards() async {
    final some = await _apiClient.getMedicalCards();
    return mapResponseToMedicalCards(some);
  }
}
