import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  final String hint;
  final List<String> items;
  final void Function(String?) onChanged;

  const CustomDropDownButton({
    super.key,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding: EdgeInsets.symmetric(horizontal: 8),
          hint: Text(
            hint,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
            size: 26,
          ),
          items: items
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
