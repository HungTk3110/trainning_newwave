import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/note_app/note_create/notes_create_screen.dart';
import 'package:training_newwave/note_app/note_detail/note_detail_cubit.dart';

// ignore: must_be_immutable
class NoteDetailScreen extends StatefulWidget {
  int id;

  NoteDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late final NoteDetailCubit _detailCubit;

  @override
  void initState() {
    super.initState();
    _detailCubit = NoteDetailCubit();
    _detailCubit.getNote(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mineShaftApprox,
      body: BlocProvider(
        create: (context) => _detailCubit,
        child: BlocBuilder<NoteDetailCubit, NoteDetailSate>(
          buildWhen: (previous, current) =>
              previous.loadingStatus != current.loadingStatus,
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  appBarCraeteNote(),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.note?.title ?? "",
                              style: AppTextStyles.whiteS48Medium,
                              textAlign: TextAlign.start,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 36),
                              child: Text(
                                state.note?.describe ?? "",
                                style: AppTextStyles.whiteS23Medium,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget appBarCraeteNote() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 8,
        bottom: 42,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => {
              Navigator.pop(context, true),
            },
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
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotesCreateScreen(id: widget.id),
                ),
              );

              if (result == true) {
                _detailCubit.getNote(widget.id);
              }
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.mineShaft,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(13),
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
