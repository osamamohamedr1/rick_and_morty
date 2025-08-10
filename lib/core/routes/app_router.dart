import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/networking/api_service.dart';
import 'package:rick_and_morty/core/routes/routes.dart';
import 'package:rick_and_morty/features/home/data/data_sources/home_local_data_source.dart';
import 'package:rick_and_morty/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:rick_and_morty/features/home/data/repos_impl/home_repo_impl.dart';
import 'package:rick_and_morty/features/home/domain/use_case/home_use_case.dart';
import 'package:rick_and_morty/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:rick_and_morty/features/home/presentation/views/home_view.dart';
import 'package:rick_and_morty/features/splash/presentation/views/splash_view.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => Scaffold(body: SplashView()));
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: BlocProvider(
              create: (context) => HomeCubit(
                HomeGetCharactersUseCase(
                  HomeRepoImpl(
                    homeLocalDataSource: HomeLocalDataSource(),
                    homeRemoteDataSource: HomeRemoteDataSource(
                      apiService: ApiService(Dio()),
                    ),
                  ),
                ),
              )..getCharactersList(),
              child: HomeView(),
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route founded in ${settings.name}')),
          ),
        );
    }
  }
}
