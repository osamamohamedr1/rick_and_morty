import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_and_morty/core/utils/assets.dart';
import 'package:rick_and_morty/core/utils/spacing.dart';
import 'package:rick_and_morty/core/widgets/cusotm_text_field.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/characters_grid_view.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/explore_favorite_button.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/filter_row.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
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
              controller: _scrollController,
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

                // Characters grid handles all Bloc + pagination logic
                CharactersGridView(scrollController: _scrollController),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
