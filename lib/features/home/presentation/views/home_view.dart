import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rick_and_morty/core/routes/routes.dart';
import 'package:rick_and_morty/core/utils/assets.dart';
import 'package:rick_and_morty/core/utils/spacing.dart';
import 'package:rick_and_morty/core/widgets/cusotm_text_field.dart';
import 'package:rick_and_morty/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/character_item.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/explore_favorite_button.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/filter_row.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Assets.imagesScreensBackground,
              fit: BoxFit.cover,
              color: Colors.black,
              colorBlendMode: BlendMode.overlay,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: verticalSpace(25)),
                SliverToBoxAdapter(child: SvgPicture.asset(Assets.svgsHeader)),
                SliverToBoxAdapter(child: ExploreFavoriteButton()),
                SliverToBoxAdapter(child: verticalSpace(10)),
                SliverToBoxAdapter(
                  child: CustomSearchField(onChanged: (value) {}),
                ),
                SliverToBoxAdapter(child: verticalSpace(10)),
                SliverToBoxAdapter(
                  child: FilterRow(
                    onStatusChanged: (value) {},
                    onSpeciesChanged: (value) {},
                  ),
                ),
                SliverToBoxAdapter(child: verticalSpace(20)),

                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is GetCharactersSuccess) {
                      return SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 10,
                              childAspectRatio: .7,
                            ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return FittedBox(
                            fit: BoxFit.fill,
                            child: CharacterCard(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.characterDetails,
                                  arguments: state.books[index],
                                );
                              },
                              characterModel: state.books[index],
                            ),
                          );
                        }, childCount: state.books.length),
                      );
                    } else if (state is GetCharactersFailure) {
                      return SliverToBoxAdapter(
                        child: Center(child: Text('Error: ${state.message}')),
                      );
                    } else {
                      return const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
