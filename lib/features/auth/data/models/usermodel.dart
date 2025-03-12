import 'package:blog_application/features/auth/domain/entities/user.dart';

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
}
