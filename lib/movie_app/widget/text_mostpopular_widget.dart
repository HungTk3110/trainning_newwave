import 'package:flutter/material.dart';
import 'package:training_newwave/configs/app_styles.dart';

class TextMostPopularWidget extends StatelessWidget {
  const TextMostPopularWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 50,
        top: 26,
        bottom: 15,
      ),
      child: Text(
        "Most Popular",
        style: AppTextStyles.whiteS18Bold,
      ),
    );
  }
}
