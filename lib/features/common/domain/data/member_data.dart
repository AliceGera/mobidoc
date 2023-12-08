// ignore_for_file: public_member_api_docs

class Member {
  final int id;
  final String title;
  final String description;

  // ignore: public_member_api_docs
  Member({
    required this.id,
    required this.title,
    required this.description,
  });

  Member copyWith({
    int? id,
    String? title,
    String? description,
  }) {
    return Member(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
  static Member init() => Member(
    id:0,
    title: '',
    description: '',
  );
}
