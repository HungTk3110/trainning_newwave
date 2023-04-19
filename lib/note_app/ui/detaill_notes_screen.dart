import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/note_app/bloc/note_cubit.dart';
import 'package:training_newwave/note_app/database/note_database_helper.dart';

// ignore: must_be_immutable
class DetailNotesScreen extends StatefulWidget {
  int id;

  DetailNotesScreen({Key? key,required this.id,}) : super(key: key);

  @override
  State<DetailNotesScreen> createState() => _DetailNotesScreenState();
}

class _DetailNotesScreenState extends State<DetailNotesScreen> {
  dynamic data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.mineShaftApprox,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              appBarCraeteNote(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 40,
                        ),
                        child: Text(
                          "",
                          style: AppTextStyles.whiteS48Medium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 40,
                        ),
                        child: Text(
                          "",
                          style: AppTextStyles.whiteS23Medium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarCraeteNote() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 18,
      ),
      child: Row(
        children: [
          Container(
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
            child: InkWell(
              onTap: () => {Navigator.pop(context)},
              child: SvgPicture.asset(
                AppVectors.icNoteBack,
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.mineShaft,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(13),
            child: InkWell(
              onTap: () => {},
              child: SvgPicture.asset(
                AppVectors.icNoteEdit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
