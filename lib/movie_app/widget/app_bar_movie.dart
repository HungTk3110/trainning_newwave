import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';

class AppBarMovie extends StatelessWidget {
  const AppBarMovie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 64,
        right: 64,
        top: 24,
      ),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              style: AppTextStyles.whiteS18Medium,
              children: <TextSpan>[
                const TextSpan(text: "Hello, "),
                TextSpan(
                  text: "jane!",
                  style: AppTextStyles.whiteS18Bold,
                )
              ],
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            AppVectors.icNotification,
          ),
        ],
      ),
    );
  }
}
