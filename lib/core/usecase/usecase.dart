import 'package:blog_application/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<Type, Params> {
  Future<Either<Failure,Type>> call(Params params);
}
class NoParams {}
