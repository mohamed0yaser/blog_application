import 'package:blog_application/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_application/core/network/connection_chacker.dart';
import 'package:blog_application/core/secrets/app_secrets.dart';
import 'package:blog_application/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_application/features/auth/data/repository/auth_repository_implementation.dart';
import 'package:blog_application/features/auth/domain/usecases/current_user.dart';
import 'package:blog_application/features/auth/domain/usecases/user_login.dart';
import 'package:blog_application/features/auth/domain/usecases/user_logout.dart';
import 'package:blog_application/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_application/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_application/features/blog/data/repositories/blog_repository_implimentation.dart';
import 'package:blog_application/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog_application/features/blog/domain/usecases/get_blogs.dart';
import 'package:blog_application/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_application/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocatot = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseKey,
    debug: true,
  );
  serviceLocatot.registerLazySingleton(() => supabase.client);
  
  serviceLocatot.registerFactory(()=>InternetConnection());
  // core
  serviceLocatot.registerLazySingleton(() => AppUserCubit());

  serviceLocatot.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocatot())
    );
}

void _initAuth() {
  //dataSources
  serviceLocatot
    ..registerFactory(
      () => AuthRemoteDataSourceImplimentation(
        supabaseClient: serviceLocatot<SupabaseClient>(),
      ),
    )
    //repository
    ..registerFactory(
      () => AuthRepositoryImplementation(
        remoteDataSource: serviceLocatot<AuthRemoteDataSourceImplimentation>(),
        serviceLocatot()
      ),
    )
    //usecases
    ..registerFactory(
      () => UserSignUp(
        repository: serviceLocatot<AuthRepositoryImplementation>(),
      ),
    )
    ..registerFactory(
      () => UserLogin(serviceLocatot<AuthRepositoryImplementation>()),
    )
    ..registerFactory(
      () => CurrentUser(serviceLocatot<AuthRepositoryImplementation>()),
    )
    ..registerFactory(
      () => UserLogOut(serviceLocatot<AuthRepositoryImplementation>()),
    )
    //bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocatot<UserSignUp>(),
        userLogin: serviceLocatot<UserLogin>(), 
        currentUser: serviceLocatot<CurrentUser>(), 
        appUserCubit: serviceLocatot<AppUserCubit>(),
        userLogOut: serviceLocatot<UserLogOut>(),
      ),
    );
}

void _initBlog() {
  //dataSources
  serviceLocatot
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImplimentation(
        serviceLocatot(),
      ),
    )
    //repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImplimentation(
        serviceLocatot(),
         serviceLocatot(),
      ),
    )
    //usecases
    ..registerFactory(
      () => GetBlogs(
        serviceLocatot(),
      ),
    )
    ..registerFactory(() => UploadBlog(serviceLocatot()))
    //bloc
    ..registerLazySingleton(
      () => BlogBloc(
         
        getBlogs: serviceLocatot(), 
        uploadBlog:serviceLocatot(),
      ),
    );
}
