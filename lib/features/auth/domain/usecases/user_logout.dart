import  'package:blog_application/core/common/entities/user.dart';
  import 'package:blog_application/core/error/failures.dart';
  import 'package:blog_application/core/usecase/usecase.dart';
  import 'package:blog_application/features/auth/domain/repository/auth_repository.dart';
  import 'package:fpdart/fpdart.dart';
  
  class UserLogOut implements UseCase<User, NoParams> {
    final AuthRepository repository;
  
    UserLogOut(this.repository);
  
    @override
    Future<Either<Failure, User>> call(NoParams params) async {
      try {
        await repository.logOut();
        return Right(User(id: '', name: '', email: '')); 
      } catch (e) {
        return Left(Failure(e.toString())); // Replace with your specific `Failure` implementation.
      }
    }
  }
