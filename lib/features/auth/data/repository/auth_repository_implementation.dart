import 'package:blog_application/core/error/exceptions.dart';
import 'package:blog_application/core/error/failures.dart';
import 'package:blog_application/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_application/core/common/entities/user.dart';
import 'package:blog_application/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImplementation({required this.remoteDataSource});

   @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return Left(Failure("User not Logged in"));
      }
      return Right(user);
    } on supabase.AuthException catch (e) {
      return Left(Failure(e.message));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
  @override
  Future<Either<Failure, User>> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    return _getUser(() => remoteDataSource.logInWithEmailAndPassword(
          email: email,
          password: password,
        ));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
        {required String name,
        required String email,
        required String password}) async {
          return _getUser(() => remoteDataSource.signUpWithEmailAndPassword(
            name: name,
            email: email,
            password: password,
          ));
    }

    Future<Either<Failure,User>> _getUser(
      Future<User> Function() function,
    )async{
      final user = await function();
      try {
        
      return Right(user);
    }on supabase.AuthException catch(e){
      return Left(Failure(e.message));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
    }
    
     

}
