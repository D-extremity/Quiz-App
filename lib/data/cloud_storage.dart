// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final int bornYear;
  final String gender;
  final String courseOpted;
  const UserModel(
    this.name,
    this.bornYear,
    this.gender,
    this.courseOpted,
  );

  UserModel copyWith({
    String? name,
    int? bornYear,
    String? gender,
    String? courseOpted,
  }) {
    return UserModel(
      name ?? this.name,
      bornYear ?? this.bornYear,
      gender ?? this.gender,
      courseOpted ?? this.courseOpted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'bornYear': bornYear,
      'gender': gender,
      'courseOpted': courseOpted,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['name'] as String,
      map['bornYear'] as int,
      map['gender'] as String,
      map['courseOpted'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, bornYear: $bornYear, gender: $gender, courseOpted: $courseOpted)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.bornYear == bornYear &&
        other.gender == gender &&
        other.courseOpted == courseOpted;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        bornYear.hashCode ^
        gender.hashCode ^
        courseOpted.hashCode;
  }
}
