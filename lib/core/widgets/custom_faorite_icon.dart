import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/colors_manager.dart';

class CustomFavoriteIcon extends StatelessWidget {
  final int characterId;
  final bool isFavorite;
  final VoidCallback? onPressed;
  const CustomFavoriteIcon({
    super.key,
    required this.characterId,
    required this.isFavorite,
    this.onPressed,
    this.radius,
    this.iconSize,
  });
  final double? radius;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: radius ?? 35,
        height: radius ?? 35,
        decoration: BoxDecoration(
          color: ColorsManager.darkGreeen,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.white,
            size: iconSize ?? 40,
          ),
        ),
      ),
    );
  }
}
