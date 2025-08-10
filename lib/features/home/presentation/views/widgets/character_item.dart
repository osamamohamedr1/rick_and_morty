import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/colors_manager.dart';
import 'package:rick_and_morty/core/utils/text_styles.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/custom_faorite_icon.dart';

class CharacterCard extends StatelessWidget {
  final String name;
  final String status;
  final String imageUrl;

  const CharacterCard({
    super.key,
    required this.name,
    required this.status,
    required this.imageUrl,
  });

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
                  imageUrl: imageUrl,

                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, color: Colors.red),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text("Name:", style: Textstyles.font20GreyBold),
                    Text(name, style: Textstyles.font20GreyNormal),
                    SizedBox(height: 4),
                    Text("Status:", style: Textstyles.font20GreyBold),
                    Text(status, style: Textstyles.font20GreyNormal),
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
