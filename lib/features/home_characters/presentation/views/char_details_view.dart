import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rick_and_morty/core/utils/assets.dart';
import 'package:rick_and_morty/core/utils/colors_manager.dart';
import 'package:rick_and_morty/core/utils/spacing.dart';
import 'package:rick_and_morty/core/utils/text_styles.dart';
import 'package:rick_and_morty/features/home_characters/data/models/character_model/character_model.dart';
import 'package:rick_and_morty/features/home_characters/presentation/views/widgets/character_details_row.dart';
import 'package:rick_and_morty/features/home_characters/presentation/views/widgets/custom_cached_network_image.dart';
import 'package:rick_and_morty/features/home_characters/presentation/views/widgets/episodes_list.dart';

class CharacterDetailsView extends StatelessWidget {
  const CharacterDetailsView({super.key, required this.characterModel});
  final CharacterModel characterModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        scrolledUnderElevation: 0,
        title: SvgPicture.asset(Assets.svgsRickMortyName),
        backgroundColor: ColorsManager.darkGreeen,
        iconTheme: IconThemeData(color: ColorsManager.green, size: 30),
      ),
      backgroundColor: ColorsManager.darkGreeen,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Hero(
                  tag: 'character-${characterModel.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CustomCachedNetworkImage(
                      characterModel: characterModel,
                    ),
                  ),
                ),
              ),
              verticalSpace(20),
              CharacterDetailsRow(
                label: 'Name',
                value: characterModel.name ?? 'Unknown',
              ),
              CharacterDetailsRow(
                label: 'Status',
                value: characterModel.status ?? 'Unknown',
              ),
              CharacterDetailsRow(
                label: 'Species  ',
                value: characterModel.species ?? 'Unknown',
              ),
              CharacterDetailsRow(
                label: 'Type',
                value:
                    (characterModel.type == null ||
                        characterModel.type!.isEmpty)
                    ? 'Unknown'
                    : characterModel.type!,
              ),
              CharacterDetailsRow(
                label: 'Gender',
                value: characterModel.gender ?? 'Unknown',
              ),
              CharacterDetailsRow(
                label: 'Origin',
                value: characterModel.origin?.name ?? 'Unknown',
              ),
              CharacterDetailsRow(
                label: 'Location',
                value: characterModel.location?.name ?? 'Unknown',
              ),

              verticalSpace(20),
              Text('Episodes List', style: Textstyles.font16WhiteBold),
              verticalSpace(10),
              (characterModel.episode != null &&
                      characterModel.episode!.isNotEmpty)
                  ? EpisodesList(characterModel: characterModel)
                  : Text(
                      'No episodes available',
                      style: TextStyle(color: Colors.grey),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
