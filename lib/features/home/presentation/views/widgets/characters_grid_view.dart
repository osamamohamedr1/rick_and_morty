import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/routes/routes.dart';
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
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() async {
    final currentScrollPosition = widget.scrollController.position.pixels;
    final maxScrollExtent = widget.scrollController.position.maxScrollExtent;

    if (currentScrollPosition >= 0.7 * maxScrollExtent) {
      log('Reached near end of grid');
      if (!isLoading) {
        isLoading = true;
        await context.read<HomeCubit>().getCharactersList(
          pageNumber: pageNumber,
        );
        pageNumber++;
        isLoading = false;
      }
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  List<CharacterModel> characters = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetCharactersSuccess) {
          characters.addAll(state.characters);
        }
        if (state is GetCharactersFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (characters.isEmpty && state is GetCharactersLoading) {
          return CharactersShimmer();
        }

        if (characters.isEmpty && state is GetCharactersFailure) {
          return SliverToBoxAdapter(
            child: Center(child: Text("Error: ${state.message}")),
          );
        }

        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 10,
            childAspectRatio: .7,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            return FittedBox(
              fit: BoxFit.fill,
              child: state is GetCharactersPaginationLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CharacterCard(
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
          }, childCount: characters.length),
        );
      },
    );
  }
}
