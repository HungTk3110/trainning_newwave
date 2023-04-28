import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/model/detail_movie_entity.dart';

class ActionMovieDetailWidget extends StatelessWidget {
  final DetailMovie detailMovie;
  const ActionMovieDetailWidget({
    Key? key,
    required this.detailMovie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 27),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 62,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.coldPurple30,
            ),
            child: Center(
              child: Text(
                "Action",
                style: AppTextStyles.whiteS12bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: 24,
            margin: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.ripeLemon,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    AppVectors.icImdb,
                  ),
                  Text(
                    detailMovie.voteAverage.toString(),
                    style: AppTextStyles.blackS12bold,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            AppVectors.icShare,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SvgPicture.asset(
              AppVectors.icFavorite,
            ),
          ),
        ],
      ),
    );
  }
}
