import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../network/network_info_impl.dart';

import '../../features/auth/data/datasources/auth_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/admin_login_usecase.dart';
import '../../features/auth/domain/usecases/member_login_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/sample/data/datasources/sample_datasource.dart';
import '../../features/sample/data/repositories/sample_repository_impl.dart';
import '../../features/sample/domain/repositories/sample_repository.dart';
import '../../features/sample/domain/usecases/get_sample_usecase.dart';
import '../../features/sample/presentation/bloc/sample_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // ===== Core =====
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // ===== Auth feature =====
  sl.registerFactory<AuthBloc>(() => AuthBloc(
        memberLoginUseCase: sl(),
        adminLoginUseCase: sl(),
      ));

  sl.registerLazySingleton<MemberLoginUseCase>(() => MemberLoginUseCase(sl()));
  sl.registerLazySingleton<AdminLoginUseCase>(() => AdminLoginUseCase(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // ===== Sample feature =====
  // Bloc → Factory (fresh instance per screen)
  sl.registerFactory<SampleBloc>(() => SampleBloc(getSampleUseCase: sl()));

  // UseCase / Repository / DataSource → LazySingleton (shared)
  sl.registerLazySingleton<GetSampleUseCase>(() => GetSampleUseCase(sl()));
  sl.registerLazySingleton<SampleRepository>(() => SampleRepositoryImpl(sl()));
  sl.registerLazySingleton<SampleRemoteDataSource>(
    () => SampleRemoteDataSourceImpl(sl()),
  );
}
