import 'package:flutter_template/api/data/services_response.dart';
import 'package:flutter_template/features/common/domain/data/member_data.dart';
import 'package:flutter_template/features/common/domain/data/services_data.dart';

/// Map [ServicesResponse] to [Services]
Services mapResponseToServices(ServicesResponse response) {
  return Services(
    member: response.member
        .map(
          (e) => Member(
            id: e?.id ?? '',
            title: e?.title ?? '',
            description: e?.description ?? '',
          ),
        )
        .toList(),
  );
}
