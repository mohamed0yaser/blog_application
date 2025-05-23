import 'package:blog_application/core/error/exceptions.dart';
import 'package:blog_application/features/auth/data/models/usermodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<Usermodel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Usermodel> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Usermodel?> getCurrentUserData();
  Future<void> logOut();
}

class AuthRemoteDataSourceImplimentation implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImplimentation({required this.supabaseClient});

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<Usermodel> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw ServerException(message: "user not found");
      }
      return Usermodel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Usermodel> signUpWithEmailAndPassword({
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
      return Usermodel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  // ignore: body_might_complete_normally_nullable
  Future<Usermodel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from("profiles")
            .select()
            .eq('id', currentUserSession!.user.id);
            return Usermodel.fromJson(userData.first).copyWith(
              email: currentUserSession!.user.email,
            );
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
  @override
  Future<void> logOut() async {
    await supabaseClient.auth.signOut();
  }
 }
