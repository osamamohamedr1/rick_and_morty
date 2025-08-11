import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rick_and_morty/core/utils/assets.dart';
import 'package:rick_and_morty/core/utils/text_styles.dart';

class NoFavoriteView extends StatelessWidget {
  const NoFavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 22,
          children: [
            SvgPicture.asset(Assets.svgsNoFavorite),
            Text(
              "Dont Worry my friend,\nnot an alien penis...Flip the pickle.",
              textAlign: TextAlign.center,
              style: Textstyles.font16WhiteBold.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
