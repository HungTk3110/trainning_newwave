import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_images.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/note_app_firebase_storage/note_search_firebase/notes_search_firebase_screen.dart';
import 'package:training_newwave/note_app_firebase_storage/widget/loading_widget.dart';
import 'package:training_newwave/note_app_isar/note_create_isar/notes_create_isar_screen.dart';
import 'package:training_newwave/note_app_isar/note_edit_isar/notes_edit_isar_screen.dart';
import 'package:training_newwave/note_app_isar/note_home_isar/note_home_isar_cubit.dart';
import 'package:training_newwave/note_app_isar/note_search_isar/notes_search_isar_screen.dart';

import '../widget/item_note_isar_widget.dart';

class NoteHomeIsarScreen extends StatefulWidget {
  const NoteHomeIsarScreen({Key? key}) : super(key: key);

  @override
  State<NoteHomeIsarScreen> createState() => _NoteHomeIsarScreenState();
}

class _NoteHomeIsarScreenState extends State<NoteHomeIsarScreen> {
  late final NoteHomeIsarCubit _noteCubit;

  @override
  void initState() {
    super.initState();
    _noteCubit = NoteHomeIsarCubit();
    _noteCubit.getAllNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mineShaftApprox,
      body: BlocProvider(
        create: (context) => _noteCubit,
        child: BlocBuilder<NoteHomeIsarCubit, NoteHomeIsarSate>(
          buildWhen: (previous, current) =>
              previous.loadingStatus != current.loadingStatus ||
              previous.deleteStatus != current.deleteStatus,
          builder: (context, state) {
            debugPrint(state.listNote?.length.toString());
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: state.loadingStatus == LoadingStatus.loading
                  ? const LoadingWidget()
                  : SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appHomeBar(),
                          Expanded(
                            child: state.listNote?.isEmpty ?? true
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 32),
                                          child: Image.asset(
                                            AppImages.imgNoteNull,
                                          ),
                                        ),
                                        Text(
                                          "Create your first note !",
                                          style: AppTextStyles.whiteS20Medium,
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.separated(
                                    itemCount: state.listNote?.length ?? 0,
                                    padding: const EdgeInsets.only(bottom: 10),
                                    separatorBuilder: (BuildContext context, int index) {
                                      return const SizedBox(
                                        height: 23,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      int color = state.listNote?[index].color ?? 0;
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                        child: Dismissible(
                                          onDismissed: (direction) {
                                            _noteCubit.deleteNote(state.listNote?[index].id ?? 0);
                                          },
                                          key: UniqueKey(),
                                          direction: DismissDirection.horizontal,
                                          background: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.red,
                                            ),
                                            child: const Icon(
                                              Icons.delete_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              final result = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => NotesEditIsarScreen(
                                                      id: state.listNote?[index].id ?? 0),
                                                ),
                                              );

                                              if (result == true) {
                                                _noteCubit.getAllNote();
                                              }
                                            },
                                            child: ItemNoteWidget(
                                              title: state.listNote?[index].title ?? "",
                                              color: color,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          right: 10,
          bottom: 30,
        ),
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotesCreateIsarScreen(),
              ),
            );

            if (result == true) {
              _noteCubit.getAllNote();
            }
          },
          backgroundColor: AppColors.mineShaftApprox,
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }

  Widget appHomeBar() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 8,
        bottom: 36,
      ),
      child: Row(
        children: [
          Text(
            "Notes",
            style: AppTextStyles.whiteS43Medium,
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NoteSearchIsarScreen(),
                  ),
                );
              },
              child: SvgPicture.asset(
                AppVectors.icSearchNote,
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
              onTap: () => openDialog(context),
              child: SvgPicture.asset(
                AppVectors.icInfor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future openDialog(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Designed by - HungTk - Line 8',
                style: AppTextStyles.altoS15Medium,
              ),
              Text(
                'Redesigned by - HungTk - line 8',
                style: AppTextStyles.altoS15Medium,
              ),
              Text(
                'Illustrations - hungtk ',
                style: AppTextStyles.altoS15Medium,
              ),
              Text(
                'Icons - hungtk',
                style: AppTextStyles.altoS15Medium,
              ),
              Text(
                'Font - hungtk',
                style: AppTextStyles.altoS15Medium,
              ),
              const SizedBox(
                width: 16,
              ),
              Center(
                child: Text(
                  "Made by - HungTk - Line 8",
                  style: AppTextStyles.altoS15Medium,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
