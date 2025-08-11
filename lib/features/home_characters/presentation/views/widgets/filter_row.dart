import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/home_characters/presentation/views/widgets/drop_down_button.dart';
import 'package:rick_and_morty/features/home_characters/presentation/manager/cubit/home_cubit.dart';

class FilterRow extends StatefulWidget {
  final String searchName;
  const FilterRow({super.key, required this.searchName});

  @override
  State<FilterRow> createState() => _FilterRowState();
}

class _FilterRowState extends State<FilterRow> {
  String? selectedStatus;
  String? selectedSpecies;

  void _applyFilters() {
    context.read<HomeCubit>().getCharactersList(
      pageNumber: 1,
      name: widget.searchName.isEmpty ? null : widget.searchName,
      status: selectedStatus?.toLowerCase(),
      species: selectedSpecies?.toLowerCase(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomDropDownButton(
            hint: 'Select Status',
            items: statusOptions,
            value: selectedStatus,
            onChanged: (value) {
              setState(() {
                selectedStatus = value == 'Clear Filter' ? null : value;
              });
              _applyFilters();
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CustomDropDownButton(
            hint: 'Select Species',
            items: speciesOptions,
            value: selectedSpecies,
            onChanged: (value) {
              setState(() {
                selectedSpecies = value == 'Clear Filter' ? null : value;
              });
              _applyFilters();
            },
          ),
        ),
      ],
    );
  }
}

final statusOptions = const ['Clear Filter', 'Alive', 'Dead', 'Unknown'];
final speciesOptions = const [
  'Clear Filter',
  'Human',
  'Alien',
  'Humanoid',
  'Animal',
  'Robot',
  'Cronenberg',
  'Disease',
  'Mythological Creature',
  'Poopybutthole',
];
