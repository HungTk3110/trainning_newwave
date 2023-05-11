import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/note_app_firebase_storage/note_create_firebase/app_baar.dart';
import 'package:training_newwave/note_app_firebase_storage/note_create_firebase/note_create_firebase_cubit.dart';

class NotesCreateFirebaseScreen extends StatefulWidget {
  const NotesCreateFirebaseScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NotesCreateFirebaseScreen> createState() =>
      _NotesCreateFirebaseScreenState();
}

class _NotesCreateFirebaseScreenState extends State<NotesCreateFirebaseScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late final NoteCreateFirebaseCubit _noteCubit;

  @override
  void initState() {
    super.initState();
    _noteCubit = NoteCreateFirebaseCubit();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        onTap: () async {
          await openDialogSave(context);
        },
      ),
      body: BlocProvider(
        create: (context) => _noteCubit,
        child: BlocBuilder<NoteCreateFirebaseCubit, NoteCreateFirebaseSate>(
          buildWhen: (previous, current) =>
              previous.loadingStatus != current.loadingStatus,
          builder: (context, state) {
            return state.loadingStatus == LoadingStatus.loading
                ? const SizedBox()
                : Container(
                    color: AppColors.mineShaftApprox,
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.only(
                            left: 28,
                            right: 28,
                            bottom: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _textInputWidget(
                                textHint: 'Title',
                                textEditingController: _titleController,
                                textStyle: AppTextStyles.whiteS48Medium,
                                textStyleHint: AppTextStyles.dustyGrayS48Medium,
                              ),
                              Expanded(
                                child: _textInputWidget(
                                  textHint: 'Type something...',
                                  textEditingController: _descriptionController,
                                  textStyle: AppTextStyles.whiteS23Medium,
                                  textStyleHint:
                                      AppTextStyles.dustyGrayS23Medium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget appBarCreateNote() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 8,
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
          InkWell(
            onTap: () => {
              openDialogSave(context),
            },
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
                        saveItem();
                        Navigator.of(context)
                          ..pop()
                          ..pop(true);
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

  Future<void> saveItem() async {
    List<int> listColor = [
      Colors.pinkAccent.value,
      Colors.blue.value,
      Colors.amber.value,
      Colors.cyan.value,
    ];
    final random = Random();
    await _noteCubit.addNote(
      _titleController.text,
      _descriptionController.text,
      listColor[random.nextInt(listColor.length)],
    );
  }

  Widget _textInputWidget({
    required String textHint,
    required TextEditingController textEditingController,
    required TextStyle textStyle,
    required TextStyle textStyleHint,
  }) {
    return TextField(
      controller: textEditingController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      autofocus: true,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: textHint,
        hintStyle: textStyleHint,
        fillColor: AppColors.dustyGray,
      ),
      style: textStyle,
    );
  }
}
