// ignore_for_file: public_member_api_docs

class MedicalCardsMember {
  final int id;
  final String name;
  final String description;
  final int number;

  // ignore: public_member_api_docs
  MedicalCardsMember({
    required this.id,
    required this.name,
    required this.description,
    required this.number,
  });

  MedicalCardsMember copyWith({
    int? id,
    String? name,
    String? description,
    int? number,
  }) {
    return MedicalCardsMember(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      number: number ?? this.number,
    );
  }
}
