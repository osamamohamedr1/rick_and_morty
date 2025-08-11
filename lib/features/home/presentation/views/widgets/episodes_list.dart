import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/colors_manager.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/character_model.dart';

class EpisodesList extends StatelessWidget {
  const EpisodesList({super.key, required this.characterModel});

  final CharacterModel characterModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: characterModel.episode!
          .map(
            (e) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(e, style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.play_circle_fill, color: ColorsManager.green),
              onTap: () {},
            ),
          )
          .toList(),
    );
  }
}
