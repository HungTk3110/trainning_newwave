import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_vectors.dart';

class AppBarEditNote extends StatelessWidget implements PreferredSizeWidget {
  final Function() openDialogSave;

  const AppBarEditNote({
    Key? key,
    required this.openDialogSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mineShaftApprox,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 50,
          bottom: 36,
        ),
        child: Row(
          children: [
            InkWell(
              onTap: () => {Navigator.pop(context, true)},
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.mineShaft,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 13,
                ),
                child: SvgPicture.asset(
                  AppVectors.icNoteBack,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap:openDialogSave,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.mineShaft,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(13),
                margin: const EdgeInsets.only(left: 22),
                child: SvgPicture.asset(
                  AppVectors.icNoteEdit,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>const Size.fromHeight(96);
}
