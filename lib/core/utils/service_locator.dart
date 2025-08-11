import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/core/networking/api_service.dart';
import 'package:rick_and_morty/features/home/data/data_sources/home_local_data_source.dart';
import 'package:rick_and_morty/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:rick_and_morty/features/home/data/repos_impl/home_repo_impl.dart';
import 'package:rick_and_morty/features/home/domain/use_case/home_use_case.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<ApiService>(ApiService(getIt<Dio>()));

  getIt.registerSingleton<HomeLocalDataSource>(HomeLocalDataSource());
  getIt.registerSingleton<HomeRemoteDataSource>(
    HomeRemoteDataSource(apiService: getIt<ApiService>()),
  );

  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      homeLocalDataSource: getIt<HomeLocalDataSource>(),
      homeRemoteDataSource: getIt<HomeRemoteDataSource>(),
    ),
  );

  getIt.registerSingleton<HomeGetCharactersUseCase>(
    HomeGetCharactersUseCase(getIt<HomeRepoImpl>()),
  );
}
