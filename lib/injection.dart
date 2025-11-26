import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:medijob_connect/data/datasources/remote/auth_remote_datasource.dart';
import 'package:medijob_connect/data/datasources/remote/job_remote_datasource.dart';
import 'package:medijob_connect/data/repositories/auth_repository_impl.dart';
import 'package:medijob_connect/data/repositories/job_repository_impl.dart';
import 'package:medijob_connect/domain/usecases/sign_in_with_email.dart';
import 'package:medijob_connect/domain/usecases/sign_in_with_google.dart';
import 'package:medijob_connect/domain/usecases/get_jobs.dart';
import 'package:medijob_connect/domain/usecases/apply_to_job.dart';

import 'data/datasources/remote/job_remote_data_sources.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/job_repository.dart';
import 'domain/usecases/apply_to_job.dart';
import 'domain/usecases/get_jobs.dart';
import 'domain/usecases/sign_in_with_email.dart';
import 'domain/usecases/sign_in_with_google.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Datasources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl(), sl()));
  sl.registerLazySingleton<JobRemoteDataSource>(
      () => JobRemoteDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: sl()));
  sl.registerLazySingleton<JobRepository>(
      () => JobRepositoryImpl(jobRemoteDataSource: sl()));

  // Usecases
  sl.registerLazySingleton(() => SignInWithEmail(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  sl.registerLazySingleton(() => GetJobs(sl()));
  sl.registerLazySingleton(() => ApplyToJob(sl()));
}

class JobRepositoryImpl {}

class AuthRemoteDataSource {}

class AuthRemoteDataSourceImpl {
  AuthRemoteDataSourceImpl(Object object, Object object2);
}
