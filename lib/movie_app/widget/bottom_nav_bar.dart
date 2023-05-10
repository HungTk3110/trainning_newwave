import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_vectors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onPageChange;
  static List<String> bottomNavigationBarVectorList = [
    AppVectors.icHomeMovieBottomNav,
    AppVectors.icFavoriteMovieBottomNav,
    AppVectors.icTicketMovieBottomNav,
    AppVectors.icAccountMovieBottomNav,
    AppVectors.icShuffleMovieBottomNav,
  ];

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onPageChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.white20,
          width: 1,
        ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            AppColors.sanJuan,
            AppColors.eastBay,
          ],
          tileMode: TileMode.clamp,
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
            tileMode: TileMode.clamp,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 68,
          vertical: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildIcon(currentIndex),
        ),
      ),
    );
  }

  List<Widget> buildIcon(int currentIndex) {
    return List<Widget>.generate(
      bottomNavigationBarVectorList.length,
      (index) {
        bool isChoose = currentIndex == index;
        return InkWell(
          onTap: () {
            onPageChange(index);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                bottomNavigationBarVectorList[index],
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  isChoose ? Colors.white : AppColors.white75,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 8),
              Visibility(
                visible: isChoose,
                replacement: const SizedBox(height: 4),
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
