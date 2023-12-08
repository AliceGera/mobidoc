// ignore_for_file: public_member_api_docs, depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'services_response.g.dart';

// ignore: public_member_api_docs
@JsonSerializable(explicitToJson: true)
class ServicesResponse {
  @JsonKey(name: 'hydra:member')
  final List<MemberResponse?> member;

  const ServicesResponse({
    required this.member,
  });

  factory ServicesResponse.fromJson(Map<String, dynamic> json) => _$ServicesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MemberResponse {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;

  const MemberResponse({
    required this.id,
    required this.title,
    required this.description,
  });

  factory MemberResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MemberResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MemberResponseToJson(this);
}
