import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/colors_manager.dart';

class CusomFavoriteIcon extends StatelessWidget {
  const CusomFavoriteIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: ColorsManager.darkGreeen,
      child: Icon(Icons.star, color: Colors.white, size: 40),
    );
  }
}
