import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/colors_manager.dart';
import 'package:rick_and_morty/core/utils/spacing.dart';
import 'package:rick_and_morty/core/utils/text_styles.dart';

class FavoriteCharacterCard extends StatelessWidget {
  final String name;
  final String species;
  final String gender;
  final String imageUrl;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  const FavoriteCharacterCard({
    super.key,
    required this.name,
    required this.species,
    required this.gender,
    required this.imageUrl,
    this.onTap,
    this.onFavorite,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorsManager.green,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
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
            horizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Textstyles.font20GreyBold),
                  verticalSpace(4),
                  Text(species, style: Textstyles.font14GreyNormal),
                  Text(gender, style: Textstyles.font14GreyNormal),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.star_border,
                color: ColorsManager.darkGreeen,
                size: 33,
              ),
              onPressed: onFavorite,
            ),
          ],
        ),
      ),
    );
  }
}
