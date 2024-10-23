import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:eventown/features/forgot_password/data/repositories/forgot_password_repo.dart';
import 'package:eventown/features/home/data/repositories/home_repo.dart';
import 'package:eventown/features/sign_in/data/repositories/sign_in_repo.dart';
import 'package:eventown/features/sign_up/data/repositories/sign_up_repo.dart';
import 'package:get_it/get_it.dart';
import '../connection/network_info.dart';
import '../cubit/global_cubit.dart';
import '../databases/api/dio_consumer.dart';
import '../databases/cache/cache_helper.dart';

final sl = GetIt.instance;
void initServiceLocator() {
//!external
  sl.registerLazySingleton(() => CacheHelper());
  sl.registerLazySingleton(() => GlobalCubit(sl<SignInRepo>()));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => NetworkInfoImpl(sl<DataConnectionChecker>()));
  sl.registerLazySingleton(() => DioConsumer(sl<Dio>(), sl<NetworkInfoImpl>()));
  //repos
  sl.registerLazySingleton(() => SignInRepo(sl<DioConsumer>()));
  sl.registerLazySingleton(() => SignUpRepo(sl<DioConsumer>()));
  sl.registerLazySingleton(() => ForgotPasswordRepo(sl<DioConsumer>()));
  sl.registerLazySingleton(() => HomeRepo(sl<DioConsumer>()));
}
