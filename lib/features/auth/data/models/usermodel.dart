import 'package:blog_application/core/common/entities/user.dart';

class Usermodel extends User {
  Usermodel({
    required super.id, 
    required super.email, 
    required super.name,
    });
  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }
    Usermodel copyWith({String? id, String? email, String? name}) {
    return Usermodel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
