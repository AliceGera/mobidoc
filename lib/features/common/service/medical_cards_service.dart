// ignore_for_file: public_member_api_docs
import 'package:flutter_template/features/common/domain/data/medical_card/medical_cards_data.dart';
import 'package:flutter_template/features/common/domain/repository/medical_cards_repository.dart';

class MedicalCardsService {
  final MedicalCardsRepository _medicalCardsRepository;

  MedicalCardsService(this._medicalCardsRepository);

  Future<MedicalCards> getMedicalCards() async {
    return _medicalCardsRepository.getMedicalCards();
  }
}
