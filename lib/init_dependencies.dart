import 'package:blog_application/core/secrets/app_secrets.dart';
import 'package:blog_application/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_application/features/auth/data/repository/auth_repository_implementation.dart';
import 'package:blog_application/features/auth/domain/usecases/user_login.dart';
import 'package:blog_application/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocatot = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseKey,
    debug: true,
  );
  serviceLocatot.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocatot.registerFactory(
    () => AuthRemoteDataSourceImplimentation(
      supabaseClient: serviceLocatot<SupabaseClient>(),
    ),
  );
  serviceLocatot.registerFactory(
    () => AuthRepositoryImplementation(
      remoteDataSource: serviceLocatot<AuthRemoteDataSourceImplimentation>(),
    ),
  );
  serviceLocatot.registerFactory(
    () => UserSignUp(
      repository: serviceLocatot<AuthRepositoryImplementation>(),
    ),
  );

  serviceLocatot.registerFactory(
    () =>
        UserLogin(serviceLocatot<AuthRepositoryImplementation>()),
  );
  
  serviceLocatot.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocatot<UserSignUp>(),
      userLogin: serviceLocatot<UserLogin>(),
    )
  );
}
