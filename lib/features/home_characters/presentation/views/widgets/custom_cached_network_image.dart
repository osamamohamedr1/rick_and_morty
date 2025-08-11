import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/assets.dart';
import 'package:rick_and_morty/core/utils/const.dart';
import 'package:rick_and_morty/features/home_characters/data/models/character_model/character_model.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({super.key, required this.characterModel});

  final CharacterModel characterModel;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.fill,
      imageUrl: characterModel.image ?? errorImageUrl,
      placeholder: (context, url) => Center(
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset(height: 310, width: 290, Assets.imagesLoader),
        ),
      ),
      errorWidget: (context, url, error) =>
          Icon(Icons.error, color: Colors.red, size: 40),
    );
  }
}
