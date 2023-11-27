// ignore_for_file: public_member_api_docs

class DoctorMember {
  final int id;
  final String name;
  final String bio;
  final String speciality;

  // ignore: public_member_api_docs
  DoctorMember({
    required this.id,
    required this.name,
    required this.bio,
    required this.speciality,
  });

  DoctorMember copyWith({
    int? id,
    String? name,
    String? bio,
    String? speciality,
  }) {
    return DoctorMember(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      speciality: speciality ?? this.speciality,
    );
  }
}
