import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/colors_manager.dart';
import 'package:rick_and_morty/core/utils/text_styles.dart';

class CustomDropDownButton extends StatelessWidget {
  final String hint;
  final List<String> items;
  final void Function(String?) onChanged;
  final String? value;

  const CustomDropDownButton({
    super.key,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: ColorsManager.green,
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding: EdgeInsets.symmetric(horizontal: 8),
          value: items.contains(value) ? value : null,
          isExpanded: true,
          hint: Text(
            hint,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Textstyles.font14GreyNormal.copyWith(fontSize: 15),
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: ColorsManager.grey,
            size: 26,
          ),
          items: items
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(
                    e,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Textstyles.font14GreyNormal.copyWith(fontSize: 14),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
