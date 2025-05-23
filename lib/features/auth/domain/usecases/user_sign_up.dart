import 'package:blog_application/core/error/failures.dart';
import 'package:blog_application/core/usecase/usecase.dart';
import 'package:blog_application/core/common/entities/user.dart';
import 'package:blog_application/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository repository;

  UserSignUp({required this.repository});

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await repository.signUpWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
