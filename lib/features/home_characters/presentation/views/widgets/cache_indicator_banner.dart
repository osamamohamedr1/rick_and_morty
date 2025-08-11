import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/text_styles.dart';

class CacheIndicatorBanner extends StatelessWidget {
  const CacheIndicatorBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange.withOpacity(0.8),
            Colors.amber.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.wifi_off, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Offline Mode - Showing cached data",
              style: Textstyles.font14WhiteNormal.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(Icons.cloud_off, color: Colors.white.withOpacity(0.7), size: 18),
        ],
      ),
    );
  }
}
