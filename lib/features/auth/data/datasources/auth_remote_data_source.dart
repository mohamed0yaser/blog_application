import 'package:blog_application/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImplimentation implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImplimentation({required this.supabaseClient});
  @override
  Future<String> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement logInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
      if (response.user == null) {
        throw ServerException(message: "user not found");
      }
      return response.user!.id;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
