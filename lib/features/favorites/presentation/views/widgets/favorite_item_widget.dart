import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/colors_manager.dart';
import 'package:rick_and_morty/core/utils/const.dart';
import 'package:rick_and_morty/core/utils/spacing.dart';
import 'package:rick_and_morty/core/utils/text_styles.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/character_model.dart';
import 'package:rick_and_morty/core/widgets/custom_faorite_icon.dart';

class FavoriteCharacterCard extends StatelessWidget {
  final CharacterModel characterModel;
  final VoidCallback? onTap;
  final bool isFavorite;

  const FavoriteCharacterCard({
    super.key,
    this.onTap,
    required this.isFavorite,
    required this.characterModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorsManager.green,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Hero(
            tag: 'character-${characterModel.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: characterModel.image ?? errorImageUrl,
                fit: BoxFit.cover,
                height: 100,
                width: 100,
                placeholder: (context, url) => SizedBox(
                  height: 90,
                  width: 90,
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: Colors.red),
              ),
            ),
          ),
          horizontalSpace(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  characterModel.name ?? '',
                  style: Textstyles.font20GreyBold,
                ),
                verticalSpace(4),
                Text(
                  characterModel.species ?? '',
                  style: Textstyles.font14GreyNormal,
                ),
                Text(
                  characterModel.gender ?? '',
                  style: Textstyles.font14GreyNormal,
                ),
              ],
            ),
          ),
          CustomFavoriteIcon(
            radius: 40,
            iconSize: 30,
            characterId: characterModel.id ?? 0,
            isFavorite: isFavorite,
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
