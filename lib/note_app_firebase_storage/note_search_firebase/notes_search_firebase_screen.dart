import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_images.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/note_entity.dart';
import 'package:training_newwave/note_app_firebase_storage/note_edit_firebase/notes_edit_firebase_screen.dart';
import 'package:training_newwave/note_app_firebase_storage/note_search_firebase/note_search_firebase_cubit.dart';
import 'package:training_newwave/note_app_firebase_storage/widget/loading_widget.dart';

import '../widget/item_note_widget.dart';

class NoteSearchFirebaseScreen extends StatefulWidget {
  const NoteSearchFirebaseScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NoteSearchFirebaseScreen> createState() =>
      _NoteSearchFirebaseScreenState();
}

class _NoteSearchFirebaseScreenState extends State<NoteSearchFirebaseScreen> {
  late final NoteSearchFirebaseCubit _noteCubit;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _noteCubit = NoteSearchFirebaseCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mineShaftApprox,
      body: BlocProvider(
        create: (context) => _noteCubit,
        child: BlocBuilder<NoteSearchFirebaseCubit, NoteSearchFirebaseSate>(
          buildWhen: (previous, current) =>
              previous.loadingStatus != current.loadingStatus,
          builder: (context, state) {
            return SizedBox(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    appHomeBar(),
                    Expanded(
                      child: state.loadingStatus == LoadingStatus.init
                          ? const SizedBox()
                          : state.loadingStatus == LoadingStatus.loading
                              ? const LoadingWidget()
                              : state.listNote!.isEmpty
                                  ? searchNotFound()
                                  : _listSearchNoteWidget(
                                      listNote: state.listNote ?? [],
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

  Widget searchNotFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Image.asset(
            AppImages.imgNoteSearchNull,
          ),
        ),
        Text(
          "File not found. Try searching again.",
          style: AppTextStyles.whiteS20Medium,
        ),
      ],
    );
  }

  Widget appHomeBar() {
    return Container(
      margin: const EdgeInsets.only(
        left: 28,
        right: 28,
        top: 34,
        bottom: 36,
      ),
      padding: const EdgeInsets.only(
        left: 38,
        right: 12,
      ),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.mineShaft,
      ),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        style: AppTextStyles.silverS20Medium,
        textInputAction: TextInputAction.done,
        onChanged: (value) {
          if (value.isNotEmpty) {
            _noteCubit.searchNote(value);
          } else {
            _noteCubit.clearSearch();
          }
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: InkWell(
            onTap: () {
              _searchController.text = "";
              _noteCubit.clearSearch();
            },
            child: const Icon(
              Icons.clear,
              color: Colors.white54,
            ),
          ),
          hintText: "Search by the keyword...",
          hintStyle: AppTextStyles.silverS20Medium,
        ),
      ),
    );
  }

  Widget _listSearchNoteWidget({required List<NoteEntity> listNote}) {
    return ListView.separated(
      itemCount: listNote.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 23,
        );
      },
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: InkWell(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotesEditFirebaseScreen(
                    id: listNote[index].id,
                  ),
                ),
              );
              if (result == true) {
                if (!mounted) return;
                Navigator.of(context).pop(true);
              }
            },
            child: ItemNoteWidget(
              title: listNote[index].title ?? "",
              color: listNote[index].color ?? 0,
            ),
          ),
        );
      },
    );
  }
}
