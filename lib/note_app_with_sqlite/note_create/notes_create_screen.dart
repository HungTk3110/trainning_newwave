import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/note_app_with_sqlite/note_create/note_create_cubit.dart';
import 'package:training_newwave/note_app_with_sqlite/widget/app_bar_create_note.dart';

class NotesCreateScreen extends StatefulWidget {
  final int? id;

  const NotesCreateScreen({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<NotesCreateScreen> createState() => _NotesCreateScreenState();
}

class _NotesCreateScreenState extends State<NotesCreateScreen> {
  late TextEditingController _titleController;

  late TextEditingController _descriptionController;
  late final NoteCreateCubit _noteCubit;

  @override
  void initState() {
    super.initState();
    _noteCubit = NoteCreateCubit();

    _init();
  }

  void _init() async {
    await _noteCubit.getNote(widget.id ?? 0);
    if (widget.id != null) {
      _titleController = TextEditingController(
        text: _noteCubit.state.note?.title ?? "",
      );
      _descriptionController = TextEditingController(
        text: _noteCubit.state.note?.describe ?? "",
      );
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCreateNote(
        openDialogSave: () async {
          await openDialogSave(context);
        },
      ),
      backgroundColor: AppColors.mineShaftApprox,
      body: BlocProvider(
        create: (context) => _noteCubit,
        child: BlocBuilder<NoteCreateCubit, NoteCreateSate>(
          buildWhen: (previous, current) =>
              previous.statusGet != current.statusGet,
          builder: (context, state) {
            return state.statusGet == LoadingStatus.loading
                ? const SizedBox()
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
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
                              child: Padding(
                                padding: const EdgeInsets.only(top: 36),
                                child: _textInputWidget(
                                  textHint: 'Type something...',
                                  textEditingController: _descriptionController,
                                  textStyle: AppTextStyles.whiteS23Medium,
                                  textStyleHint: AppTextStyles.dustyGrayS23Medium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  Future<void> openDialogSave(BuildContext context) {
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
                        if (widget.id == null) {
                          saveItem();
                          Navigator.of(context)
                            ..pop()
                            ..pop(true);
                        } else {
                          saveItem();
                          Navigator.of(context)
                            ..pop()
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

  Future<void> saveItem() async {
    List<int> listColor = [
      Colors.pinkAccent.value,
      Colors.blue.value,
      Colors.amber.value,
      Colors.cyan.value,
    ];
    final random = Random();
    if (widget.id == null) {
      await _noteCubit.addNote(
        _titleController.text,
        _descriptionController.text,
        listColor[random.nextInt(listColor.length)],
      );
    } else {
      await _noteCubit.updateNote(
        id: widget.id ?? 0,
        title: _titleController.text,
        describe: _descriptionController.text,
        color: listColor[random.nextInt(listColor.length)],
      );
    }
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
