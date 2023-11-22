// ignore_for_file: public_member_api_docs

import 'package:dio/dio.dart';
import 'package:flutter_template/api/data/services_response.dart';
import 'package:flutter_template/api/strings/api_strings.dart';
import 'package:retrofit/retrofit.dart';

part 'services_api.g.dart';

/// Интерфейс API клиента.
@RestApi()
abstract class ServicesApi {
  factory ServicesApi(Dio dio) = _ServicesApi;

  // ignore: public_member_api_docs
  @GET(ServicesApiStrings.services)
  Future<ServicesResponse> getServices();
}
