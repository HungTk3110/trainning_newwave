import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/model/movie_collection_entity.dart';

class ItemCollectionHome extends StatelessWidget {
  final MovieCollection movieCollection;

  const ItemCollectionHome({
    Key? key,
    required this.movieCollection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 95,
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
        borderRadius: const BorderRadius.all(
            Radius.circular(15.0) //                 <--- border radius here
            ),
      ),
      child: Container(
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
          border: Border.all(
            width: 1,
            color: AppColors.white20,
          ),
          borderRadius: const BorderRadius.all(
              Radius.circular(15.0) //                 <--- border radius here
              ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              child: SvgPicture.asset(
                movieCollection.assetImage,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 15,
              ),
              child: Text(
                movieCollection.title,
                style: AppTextStyles.whiteS10Medium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
