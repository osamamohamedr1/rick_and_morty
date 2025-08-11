import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_and_morty/core/utils/assets.dart';
import 'package:rick_and_morty/core/utils/colors_manager.dart';
import 'package:rick_and_morty/core/utils/spacing.dart';
import 'package:rick_and_morty/core/widgets/cusotm_text_field.dart';
import 'package:rick_and_morty/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/cache_indicator_banner.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/characters_grid_view.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/explore_favorite_button.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/filter_row.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static const Duration _searchDebounceDelay = Duration(milliseconds: 500);
  static const EdgeInsets _bottomPadding = EdgeInsets.only(bottom: 16);

  late final ScrollController _scrollController;
  late final FocusNode _searchFocusNode;
  Timer? _debounceTimer;
  String _searchName = '';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchFocusNode = FocusNode();

    _scrollController.addListener(() {
      if (_searchFocusNode.hasFocus) {
        _searchFocusNode.unfocus();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialCharacters();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchFocusNode.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _loadInitialCharacters() {
    context.read<HomeCubit>().getCharactersList(pageNumber: 1);
  }

  void _onSearchChanged(String value) {
    setState(() => _searchName = value);
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_searchDebounceDelay, () {
      context.read<HomeCubit>().getCharactersList(
        pageNumber: 1,
        name: _searchName.isEmpty ? null : _searchName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(children: [_buildBackground(), _buildContent()]),
      ),
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: Image.asset(
        Assets.imagesScreensBackground,
        fit: BoxFit.cover,
        color: Colors.black,
        colorBlendMode: BlendMode.overlay,
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return RefreshIndicator(
            backgroundColor: ColorsManager.green,
            color: ColorsManager.darkGreeen,
            onRefresh: () {
              return context.read<HomeCubit>().getCharactersList(pageNumber: 1);
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                sliverVerticalSpace(10),
                SliverToBoxAdapter(child: SvgPicture.asset(Assets.svgsHeader)),
                const SliverToBoxAdapter(child: ExploreFavoriteButton()),
                sliverVerticalSpace(10),

                // Show cache indicator banner when data is from cache
                if (state is GetCharactersSuccess && state.isFromCache)
                  const SliverToBoxAdapter(child: CacheIndicatorBanner()),

                if (state is GetCharactersSuccess && state.isFromCache)
                  sliverVerticalSpace(10),

                SliverToBoxAdapter(
                  child: CustomSearchField(
                    onChanged: _onSearchChanged,
                    focusNode: _searchFocusNode,
                  ),
                ),
                sliverVerticalSpace(10),
                SliverToBoxAdapter(child: FilterRow(searchName: _searchName)),
                sliverVerticalSpace(20),
                SliverPadding(
                  padding: _bottomPadding,
                  sliver: CharactersGridView(
                    scrollController: _scrollController,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  SliverToBoxAdapter sliverVerticalSpace(double height) =>
      SliverToBoxAdapter(child: verticalSpace(height));
}
