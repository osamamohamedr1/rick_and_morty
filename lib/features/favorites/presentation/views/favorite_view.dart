import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/utils/assets.dart';
import 'package:rick_and_morty/core/utils/colors_manager.dart';
import 'package:rick_and_morty/features/favorites/presentation/views/widgets/favorite_item_widget.dart';
import 'package:rick_and_morty/features/favorites/presentation/manager/cubit/favorites_cubit.dart';
import 'package:rick_and_morty/features/favorites/presentation/views/widgets/no_favorite_widget.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.darkGreeen,
      appBar: AppBar(
        backgroundColor: ColorsManager.darkGreeen,
        scrolledUnderElevation: 0,
        toolbarHeight: 90,
        title: Image.asset(
          Assets.imagesFavorites,
          height: 80,
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorsManager.green, size: 35),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesInitial) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is FavoritesListLoaded) {
            final favorites = state.favorites;
            if (favorites.isEmpty) {
              return NoFavoriteView();
            }
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final character = favorites[index];
                return FavoriteCharacterCard(
                  characterModel: character,
                  isFavorite: context.read<FavoritesCubit>().checkFavorite(
                    character.id,
                  ),
                  onTap: () {
                    context.read<FavoritesCubit>().removeFavorite(character.id);
                  },
                );
              },
            );
          }
          return Center(
            child: Text(
              'Error loading favorites',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
