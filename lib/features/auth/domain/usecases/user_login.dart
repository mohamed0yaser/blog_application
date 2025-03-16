import 'package:blog_application/core/error/failures.dart';
import 'package:blog_application/core/usecase/usecase.dart';
import 'package:blog_application/core/common/entities/user.dart';
import 'package:blog_application/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository repository;

  UserLogin(this.repository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await repository.logInWithEmailAndPassword(email:params.email, password:params.password,);
  }
}
class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}