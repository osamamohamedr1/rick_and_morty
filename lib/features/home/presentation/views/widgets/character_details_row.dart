import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/text_styles.dart';

class CharacterDetailsRow extends StatelessWidget {
  const CharacterDetailsRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label, value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: Textstyles.font14GreyBold),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: Textstyles.font14WhiteNormal),
          ),
        ],
      ),
    );
  }
}
