import 'package:blog_application/core/error/failures.dart';
import 'package:blog_application/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository{
  Future<Either<Failure,User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();
  Future<void> logOut();
}
