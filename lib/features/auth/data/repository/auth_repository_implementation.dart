import 'package:blog_application/core/error/exceptions.dart';
import 'package:blog_application/core/error/failures.dart';
import 'package:blog_application/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_application/features/auth/domain/entities/user.dart';
import 'package:blog_application/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImplementation({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> logInWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement logInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
        {required String name,
        required String email,
        required String password}) async {
      try {
        final user = await remoteDataSource.signUpWithEmailAndPassword(
          name: name,
          email: email,
          password: password,
        );
        return Right(user);
      }on ServerException catch (e) {
        return Left(Failure(e.message));
      }
    }
}

/* 
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImplementation({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.login(email: email, password: password);
        localDataSource.cacheUser(user);
        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final user = await localDataSource.getLastUser();
        return Right(user);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, UserModel>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.register(email: email, password: password, name: name);
        localDataSource.cacheUser(user);
        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final user = await localDataSource.getLastUser();
      return Right(user);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearUser();
  }
 */