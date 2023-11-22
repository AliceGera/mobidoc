// ignore_for_file: public_member_api_docs

import 'package:flutter_template/features/common/domain/data/member_data.dart';

class Services {
  final List<Member> member;

  // ignore: public_member_api_docs
  Services({
    required this.member,
  });

  Services copyWith({
    List<Member>? member,
  }) {
    return Services(
      member: member ?? this.member,
    );
  }
}
