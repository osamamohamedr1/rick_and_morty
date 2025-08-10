import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rick_and_morty/core/utils/assets.dart';
import 'package:rick_and_morty/core/utils/spacing.dart';
import 'package:rick_and_morty/core/widgets/cusotm_text_field.dart';
import 'package:rick_and_morty/features/home/presentation/manager/cubit/home_cubit.dart';
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

              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is GetCharactersSuccess) {
                    return SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 10,
                        childAspectRatio: .7,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return FittedBox(
                          fit: BoxFit.fitWidth,
                          child: CharacterCard(
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
                    return SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
