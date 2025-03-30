import 'package:blog_application/core/error/exceptions.dart';
import 'package:blog_application/core/error/failures.dart';
import 'package:blog_application/core/network/connection_chacker.dart';
import 'package:blog_application/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_application/core/common/entities/user.dart';
import 'package:blog_application/features/auth/data/models/usermodel.dart';
import 'package:blog_application/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImplementation(this.connectionChecker, {required this.remoteDataSource});

   @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected())){
       final session = remoteDataSource.currentUserSession;
       if (session == null) {
         return Left(Failure("User not Logged in"));
         }
         return Right(Usermodel(id: session.user!.id, email: session.user.email?? '', name: ''));
      }
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
        if (await connectionChecker.isConnected()) {
          return Right(user);
        } else {
          return Left(Failure("No Internet Connection"));
        }
    }on supabase.AuthException catch(e){
      return Left(Failure(e.message));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
    }
    
      @override
      Future<void> logOut() {
        return remoteDataSource.logOut();
      }
    
     

}
