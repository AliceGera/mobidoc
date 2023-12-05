// ignore_for_file: public_member_api_docs, depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'doctors_response.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorsResponse {
  @JsonKey(name: 'hydra:member')
  final List<MemberResponse?> member;

  const DoctorsResponse({
    required this.member,
  });

  factory DoctorsResponse.fromJson(Map<String, dynamic> json) => _$DoctorsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MemberResponse {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'speciality')
  final String? speciality;
  @JsonKey(name: 'bio')
  final String? bio;

  const MemberResponse({
    required this.id,
    required this.name,
    required this.speciality,
    required this.bio,
  });

  factory MemberResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$MemberResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MemberResponseToJson(this);
}
