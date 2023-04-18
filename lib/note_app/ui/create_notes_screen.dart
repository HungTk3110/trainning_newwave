import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/note_app/bloc/note_cubit.dart';
import 'package:training_newwave/note_app/database/database_helper.dart';

class CreateNotesScreen extends StatefulWidget {
  const CreateNotesScreen({Key? key}) : super(key: key);

  @override
  State<CreateNotesScreen> createState() => _CreateNotesScreenState();
}

class _CreateNotesScreenState extends State<CreateNotesScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late final NoteCubit _noteCubit;

  @override
  void initState() {
    super.initState();
    _noteCubit = NoteCubit();
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
                        child: TextField(
                          controller: _titleController,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Title',
                            hintStyle: AppTextStyles.dustyGrayS48Medium,
                          ),
                          style: AppTextStyles.whiteS48Medium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 40,
                        ),
                        child: TextField(
                          controller: _descriptionController,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type something...',
                            hintStyle: AppTextStyles.dustyGrayS23Medium,
                            fillColor: AppColors.dustyGray,
                          ),
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
                AppVectors.icNoteVisibility,
              ),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.mineShaft,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(13),
            margin: const EdgeInsets.only(left: 22),
            child: InkWell(
              onTap: () => {openDialogSave(context)},
              child: SvgPicture.asset(
                AppVectors.icNoteSave,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future openDialogSave(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: AppColors.mineShaftApprox,
        content: Container(
          width: 330,
          height: 236,
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 38,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppVectors.icNoteWarning,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  "Save changes ?",
                  style: AppTextStyles.altoS23Medium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // foreground
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child:
                          Text('Discard', style: AppTextStyles.whiteS18Medium),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.jungleGreen, // foreground
                      ),
                      onPressed: () {
                        addItem();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text('Save', style: AppTextStyles.whiteS18Medium),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addItem() async {
    List<int> listColor = [
      Colors.pinkAccent.value,
      Colors.blue.value,
      Colors.amber.value,
      Colors.cyan.value,
    ];
    final random = Random();
    await _noteCubit.insertNote(
      _titleController.text,
      _descriptionController.text,
      listColor[random.nextInt(listColor.length)],
    );
  }

  // Update an existing data
  Future<void> updateItem(int id) async {
    await DatabaseHelper.updateItem(
        id, _titleController.text, _descriptionController.text);
  }
}
