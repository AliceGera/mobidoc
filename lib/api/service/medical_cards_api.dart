// ignore_for_file: public_member_api_docs

import 'package:dio/dio.dart';
import 'package:flutter_template/api/data/medical_cards_response.dart';
import 'package:flutter_template/api/strings/api_strings.dart';
import 'package:retrofit/retrofit.dart';

part 'medical_cards_api.g.dart';

/// Интерфейс API клиента.
@RestApi()
abstract class MedicalCardsApi {
  factory MedicalCardsApi(Dio dio) = _MedicalCardsApi;
  // ignore: public_member_api_docs
  @GET(ApiStrings.medicalCards)
  Future<MedicalCardsResponse> getMedicalCards();
}
