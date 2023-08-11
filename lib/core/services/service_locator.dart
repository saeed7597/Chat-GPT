import 'package:get_it/get_it.dart';
import 'package:iran_gpt/features/mian/data/data_source/local_data_source.dart';
import 'package:iran_gpt/features/mian/data/data_source/remote_data_source.dart';
import 'package:iran_gpt/features/mian/data/repositories/main_repository_impl.dart';
import 'package:iran_gpt/features/mian/domain/repositories/mian_repository.dart';
import 'package:iran_gpt/features/mian/domain/use_case/delete_all_use_case.dart';
import 'package:iran_gpt/features/mian/domain/use_case/get_all_data_use_case.dart';
import 'package:iran_gpt/features/mian/domain/use_case/main_use_case.dart';
import 'package:iran_gpt/features/mian/domain/use_case/save_data_use_case.dart';
import 'package:iran_gpt/features/mian/presentation/bloc/main_bloc.dart';

final sl = GetIt.instance;

class ServiceLocator {

  static void init() {
    //Data source
    sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());
    sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

    //Repository
    sl.registerLazySingleton<MainRepository>(() => MainRepositoryImpl(sl(),sl()));

    //useCase
    sl.registerLazySingleton(() => MainUseCase(sl()));
    sl.registerLazySingleton(() => SaveDataUseCase(sl()));
    sl.registerLazySingleton(() => GetAllDataUseCase(sl()));
    sl.registerLazySingleton(() => DeleteAllUseCase(sl()));

    //bloc
    sl.registerFactory(() => MainBloc(sl(),sl(),sl(),sl()));
  }
}