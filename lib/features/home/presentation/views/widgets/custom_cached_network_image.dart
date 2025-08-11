import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/const.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/character_model.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({super.key, required this.characterModel});

  final CharacterModel characterModel;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.fill,
      imageUrl: characterModel.image ?? errorImageUrl,
      placeholder: (context, url) => Center(
        child: SizedBox(
          height: 260,
          width: 150,
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      errorWidget: (context, url, error) =>
          Icon(Icons.error, color: Colors.red, size: 40),
    );
  }
}
