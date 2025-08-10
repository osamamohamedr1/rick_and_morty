import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rick_and_morty/core/utils/assets.dart';
import 'package:rick_and_morty/core/utils/spacing.dart';
import 'package:rick_and_morty/core/widgets/cusotm_text_field.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/character_item.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/filter_row.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.imagesScreensBackground),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.overlay),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: verticalSpace(20)),
              SliverToBoxAdapter(child: SvgPicture.asset(Assets.svgsHeader)),
              SliverToBoxAdapter(
                child: CustomSearchField(onChanged: (value) {}),
              ),
              SliverToBoxAdapter(child: verticalSpace(20)),
              SliverToBoxAdapter(
                child: FilterRow(
                  onStatusChanged: (value) {},
                  onSpeciesChanged: (value) {},
                ),
              ),

              SliverToBoxAdapter(child: verticalSpace(20)),

              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300, // responsive max width per card
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,

                  childAspectRatio: .55,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return CharacterCard(
                    name: "Rick Sanchez",
                    status: "Alive",
                    imageUrl:
                        "https://rickandmortyapi.com/api/character/avatar/21.jpeg",
                  );
                }, childCount: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
