import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/assets.dart';
import 'package:rick_and_morty/core/utils/colors_manager.dart';
import 'package:rick_and_morty/core/utils/const.dart';
import 'package:rick_and_morty/core/utils/text_styles.dart';
import 'package:rick_and_morty/features/favorites/presentation/views/widgets/favorite_item_widget.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        scrolledUnderElevation: 0,
        toolbarHeight: 90,
        title: Image.asset(
          Assets.imagesFavorites,
          height: 80,
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorsManager.green, size: 40),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return FavoriteCharacterCard(
            name: 'Character $index',
            species: 'Species $index',
            gender: '',
            imageUrl: erroImageUrl,
            isFavorite: false,
          );
        },
      ),
    );
  }
}
