import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/routes/routes.dart';
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
          // Use the characters from cubit state directly instead of maintaining local list
          characters = state.characters;
        }
        if (state is GetCharactersFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        // For initial loading, show shimmer
        if (state is GetCharactersLoading) {
          return CharactersShimmer();
        }

        // For errors with no characters, show error message
        if (characters.isEmpty && state is GetCharactersFailure) {
          return SliverFillRemaining(
            child: Center(
              child: Text(
                "Error: ${state.message}",
                style: Textstyles.font16WhiteBold,
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
