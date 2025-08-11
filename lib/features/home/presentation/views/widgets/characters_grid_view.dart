import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/routes/routes.dart';
import 'package:rick_and_morty/core/utils/spacing.dart';
import 'package:rick_and_morty/core/utils/text_styles.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/character_model.dart';
import 'package:rick_and_morty/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/character_item.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/characters_shimmer.dart';

class CharactersGridView extends StatefulWidget {
  final ScrollController scrollController;
  const CharactersGridView({super.key, required this.scrollController});

  @override
  State<CharactersGridView> createState() => _CharactersGridViewState();
}

class _CharactersGridViewState extends State<CharactersGridView> {
  int pageNumber = 2;
  Timer? _debounceTimer;
  List<CharacterModel> characters = [];

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: 300),
      _checkScrollPosition,
    );
  }

  void _checkScrollPosition() {
    final position = widget.scrollController.position;
    final state = context.read<HomeCubit>().state;

    if (position.pixels >= 0.7 * position.maxScrollExtent &&
        state is! GetCharactersPaginationLoading &&
        state is! GetCharactersLoading) {
      log('called');
      context.read<HomeCubit>().getCharactersList(pageNumber: pageNumber);
      pageNumber++;
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetCharactersSuccess) {
          characters = state.characters;

          // // Show cache indicator if data is from cache
          // if (state.isFromCache) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text("Showing cached data - No internet connection"),
          //       backgroundColor: Colors.orange,
          //       duration: Duration(seconds: 3),
          //     ),
          //   );
          // }
        }
        if (state is GetCharactersFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is GetCharactersLoading) {
          return CharactersShimmer();
        }
        if (characters.isEmpty && state is GetCharactersFailure) {
          return SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, size: 90, color: Colors.white),
                  verticalSpace(16),
                  Text(
                    state.message,
                    style: Textstyles.font16WhiteBold,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 10,
            childAspectRatio: .7,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == characters.length &&
                  state is GetCharactersPaginationLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return FittedBox(
                fit: BoxFit.fill,
                child: CharacterCard(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.characterDetails,
                      arguments: characters[index],
                    );
                  },
                  characterModel: characters[index],
                ),
              );
            },
            childCount:
                characters.length +
                (state is GetCharactersPaginationLoading ? 1 : 0),
          ),
        );
      },
    );
  }
}
