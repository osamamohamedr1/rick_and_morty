import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty/core/utils/const.dart';
import 'package:rick_and_morty/core/utils/my_bloc_observer.dart';
import 'package:rick_and_morty/core/utils/service_locator.dart';
import 'package:rick_and_morty/core/routes/app_router.dart';
import 'package:rick_and_morty/core/routes/routes.dart';
import 'package:rick_and_morty/features/favorites/data/repos/favorite_repo_impl.dart';
import 'package:rick_and_morty/features/favorites/presentation/manager/cubit/favorites_cubit.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/character_model.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/location.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/origin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterModelAdapter());
  Hive.registerAdapter(LocationAdapter());
  Hive.registerAdapter(OriginAdapter());
  await Hive.openBox<CharacterModel>(kCharacterBox);
  await Hive.openBox<CharacterModel>(kFavoriteBox);
  setupServiceLocator();
  Bloc.observer = MyBlocObserver();
  runApp(RickAndMorty(appRouter: AppRouter()));
}

class RickAndMorty extends StatelessWidget {
  const RickAndMorty({super.key, required this.appRouter});
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
        create: (context) =>
            FavoritesCubit(FavoriteRepositoryImpl())..loadFavorites(),
        child: MaterialApp(
          initialRoute: Routes.splash,
          onGenerateRoute: appRouter.generateRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
