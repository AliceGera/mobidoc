// ignore_for_file: public_member_api_docs

import 'package:dio/dio.dart';
import 'package:flutter_template/api/data/doctors_response.dart';
import 'package:flutter_template/api/strings/api_strings.dart';
import 'package:retrofit/retrofit.dart';

part 'doctors_api.g.dart';

/// Интерфейс API клиента.
@RestApi()
abstract class DoctorsApi {
  factory DoctorsApi(Dio dio) = _DoctorsApi;

  // ignore: public_member_api_docs
  @GET(ApiStrings.doctors)
  Future<DoctorsResponse> getDoctors();
}
