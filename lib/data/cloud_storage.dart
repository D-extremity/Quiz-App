// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final int bornYear;
  final String gender;
  final String highestQualification;
  const UserModel(
    this.name,
    this.bornYear,
    this.gender,
    this.highestQualification,
  );

  UserModel copyWith({
    String? name,
    int? bornYear,
    String? gender,
    String? highestQualification,
  }) {
    return UserModel(
      name ?? this.name,
      bornYear ?? this.bornYear,
      gender ?? this.gender,
      highestQualification ?? this.highestQualification,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'bornYear': bornYear,
      'gender': gender,
      'highestQualification': highestQualification,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['name'] as String,
      map['bornYear'] as int,
      map['gender'] as String,
      map['highestQualification'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, bornYear: $bornYear, gender: $gender, highestQualification: $highestQualification)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.bornYear == bornYear &&
        other.gender == gender &&
        other.highestQualification == highestQualification;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        bornYear.hashCode ^
        gender.hashCode ^
        highestQualification.hashCode;
  }
}
