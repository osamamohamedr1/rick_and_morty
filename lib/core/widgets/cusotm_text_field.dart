import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    this.hintText = 'Search characters...',
    this.controller,
    this.onChanged,
    this.focusNode,
  });

  final String? hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        focusNode: focusNode,
        textInputAction: TextInputAction.search,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.grey),

          hintText: hintText,
          hintStyle: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
