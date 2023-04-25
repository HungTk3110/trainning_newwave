import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isar/isar.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/note_isar_entity.dart';
import 'package:training_newwave/note_app_firebase_storage/widget/loading_widget.dart';
import 'package:training_newwave/note_app_isar/note_edit_isar/note_edit_isar_cubit.dart';

class NotesEditIsarScreen extends StatefulWidget {
  final Id id;

  const NotesEditIsarScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<NotesEditIsarScreen> createState() => _NotesEditIsarScreenState();
}

class _NotesEditIsarScreenState extends State<NotesEditIsarScreen> {
  late TextEditingController _titleController;

  late TextEditingController _descriptionController;
  late final NoteEditIsarCubit _noteCubit;

  @override
  void initState() {
    super.initState();
    _noteCubit = NoteEditIsarCubit();

    _init();
  }

  void _init() async {
    await _noteCubit.getNote(widget.id);
    _titleController = TextEditingController(text: _noteCubit.state.note?.title ?? "");
    _descriptionController = TextEditingController(text: _noteCubit.state.note?.describe ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mineShaftApprox,
      body: BlocProvider(
        create: (context) => _noteCubit,
        child: BlocBuilder<NoteEditIsarCubit, NoteEditIsarSate>(
          buildWhen: (previous, current) => previous.loadingStatus != current.loadingStatus,
          builder: (context, state) {
            return state.loadingStatus == LoadingStatus.loading
                ? const LoadingWidget()
                : SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          appBarCraeteNote(note: state.note ?? NoteIsarEntity()),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(
                                  left: 28,
                                  right: 28,
                                  bottom: 10,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextField(
                                      controller: _titleController,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      autofocus: true,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Title',
                                        hintStyle: AppTextStyles.dustyGrayS48Medium,
                                      ),
                                      style: AppTextStyles.whiteS48Medium,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 36),
                                      child: TextField(
                                        controller: _descriptionController,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        textInputAction: TextInputAction.done,
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
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget appBarCraeteNote({
    required NoteIsarEntity note,
  }) {
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
          InkWell(
            onTap: () => {
              openDialogSave(
                context: context,
                note: note,
              ),
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
                AppVectors.icNoteEdit,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future openDialogSave({
    required BuildContext context,
    required NoteIsarEntity note,
  }) {
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
                      child: Text('Discard', style: AppTextStyles.whiteS18Medium),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.jungleGreen, // foreground
                      ),
                      onPressed: () async{
                        await saveItem(note: note);
                        if (!mounted) return;
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

  Future<void> saveItem({
    required NoteIsarEntity note,
  }) async {
    List<int> listColor = [
      Colors.pinkAccent.value,
      Colors.blue.value,
      Colors.amber.value,
      Colors.cyan.value,
    ];
    final random = Random();
    await _noteCubit.updateNote(
      note: note,
      title: _titleController.text,
      describe: _descriptionController.text,
      color: listColor[random.nextInt(
        listColor.length,
      )],
    );
  }
}
