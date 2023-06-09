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
import 'package:training_newwave/note_app_firebase_storage/widget/app_bar_edit_note_widget.dart';
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
    _titleController = TextEditingController(
      text: _noteCubit.state.note?.title ?? "",
    );
    _descriptionController = TextEditingController(
      text: _noteCubit.state.note?.describe ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _noteCubit,
      child: BlocBuilder<NoteEditIsarCubit, NoteEditIsarSate>(
        buildWhen: (previous, current) =>
            previous.loadingStatus != current.loadingStatus,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBarEditNote(
              openDialogSave: () async {
                await openDialogSave(note: state.note ?? NoteIsarEntity());
              },
            ),
            backgroundColor: AppColors.mineShaftApprox,
            body: state.loadingStatus == LoadingStatus.loading
                ? const LoadingWidget()
                : SafeArea(
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
                            textStyleHint:
                                AppTextStyles.dustyGrayS48Medium,
                          ),
                          Expanded(
                            child: _textInputWidget(
                              textHint: 'Type something...',
                              textEditingController:
                                  _descriptionController,
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
    );
  }

  Future openDialogSave({
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
                      child:
                          Text('Discard', style: AppTextStyles.whiteS18Medium),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.jungleGreen, // foreground
                      ),
                      onPressed: () async {
                        if (_titleController.text.isEmpty ||
                            _descriptionController.text.isEmpty) {
                          Navigator.pop(context);
                        } else {
                          await saveItem(note: note);
                          if (!mounted) return;
                          Navigator.of(context)
                            ..pop()
                            ..pop(true);
                        }
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
