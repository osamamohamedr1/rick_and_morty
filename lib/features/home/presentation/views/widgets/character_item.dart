import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/colors_manager.dart';
import 'package:rick_and_morty/core/utils/text_styles.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/character_model.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/custom_cached_network_image.dart';
import 'package:rick_and_morty/core/widgets/custom_faorite_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/favorites/presentation/manager/cubit/favorites_cubit.dart';

class CharacterCard extends StatelessWidget {
  final CharacterModel characterModel;
  final Function()? onTap;
  const CharacterCard({super.key, required this.characterModel, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.green,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorsManager.green, width: 2),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Hero(
                    tag: 'character-${characterModel.id}',
                    child: CustomCachedNetworkImage(
                      characterModel: characterModel,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text("Name:", style: Textstyles.font20GreyBold),
                      Text(
                        characterModel.name ?? 'Unkown',
                        style: Textstyles.font20GreyNormal,
                      ),
                      SizedBox(height: 4),
                      Text("Status:", style: Textstyles.font20GreyBold),
                      Text(
                        characterModel.status ?? 'Unkown',
                        style: Textstyles.font20GreyNormal,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 12,
              right: 12,
              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  bool isFavorite = false;
                  if (state is FavoritesListLoaded) {
                    isFavorite = state.favorites.any(
                      (fav) => fav.id == characterModel.id,
                    );
                  } else if (state is FavoritesChanged) {
                    isFavorite = state.characterId == characterModel.id
                        ? state.isFavorite
                        : false;
                  }
                  return CustomFavoriteIcon(
                    radius: 65,
                    characterId: characterModel.id ?? 0,
                    isFavorite: isFavorite,
                    onPressed: () {
                      final cubit = context.read<FavoritesCubit>();
                      if (isFavorite) {
                        cubit.removeFavorite(characterModel.id ?? 0);
                      } else {
                        cubit.addFavorite(characterModel);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
