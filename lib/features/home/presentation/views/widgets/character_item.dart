import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/colors_manager.dart';
import 'package:rick_and_morty/core/utils/const.dart';
import 'package:rick_and_morty/core/utils/text_styles.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/character_model.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/custom_faorite_icon.dart';

class CharacterCard extends StatelessWidget {
  final CharacterModel characterModel;

  const CharacterCard({super.key, required this.characterModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.green,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorsManager.green, width: 1),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: characterModel.image ?? erroIMageUrl,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, color: Colors.red),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
          Positioned(top: 8, left: 4, child: CusomFavoriteIcon()),
        ],
      ),
    );
  }
}
