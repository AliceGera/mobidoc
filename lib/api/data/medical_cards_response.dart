// ignore_for_file: public_member_api_docs, depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'medical_cards_response.g.dart';

// ignore: public_member_api_docs
@JsonSerializable(explicitToJson: true)
class MedicalCardsResponse {
  @JsonKey(name: 'hydra:member')
  final List<MemberResponse?> member;

  const MedicalCardsResponse({
    required this.member,
  });

  factory MedicalCardsResponse.fromJson(Map<String, dynamic> json) => _$MedicalCardsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalCardsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MemberResponse {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'number')
  final int? number;
  const MemberResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.number,
  });

  factory MemberResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MemberResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MemberResponseToJson(this);
}
