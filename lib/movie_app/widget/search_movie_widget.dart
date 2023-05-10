import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';

class SearchMovieWidget extends StatelessWidget {
  const SearchMovieWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        left: 50,
        right: 50,
      ),
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            AppColors.sanJuan,
            AppColors.eastBay,
          ],
          tileMode: TileMode.mirror,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(
          top: 14,
          right: 17,
          bottom: 14,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              AppColors.scampi,
              AppColors.aquamarineBlue,
            ],
            tileMode: TileMode.mirror,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: SvgPicture.asset(
              AppVectors.icSearch,
            ),
            hintText: "Search",
            contentPadding: const EdgeInsets.only(bottom: 10),
            hintStyle: AppTextStyles.white50S18Medium,
            suffixIcon: SizedBox(
              width: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    AppVectors.icLine1,
                  ),
                  SvgPicture.asset(
                    AppVectors.icVoice,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
