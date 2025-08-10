import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/home/presentation/views/widgets/drop_down_button.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({
    super.key,
    required this.onStatusChanged,
    required this.onSpeciesChanged,
  });
  final void Function(String?) onStatusChanged;
  final void Function(String?) onSpeciesChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomDropDownButton(
            hint: 'Select Status',
            items: statusOptions,
            onChanged: onStatusChanged,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CustomDropDownButton(
            hint: 'Select Species',
            items: speciesOptions,
            onChanged: onSpeciesChanged,
          ),
        ),
      ],
    );
  }
}

final statusOptions = const ['Alive', 'Dead', 'Unknown'];
final speciesOptions = const ['Human', 'Alien', 'Other'];
