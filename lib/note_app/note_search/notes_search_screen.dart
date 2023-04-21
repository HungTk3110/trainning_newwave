import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_images.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/note_app/note_detail/note_detail_screen.dart';
import 'package:training_newwave/note_app/note_search/note_search_cubit.dart';

class NoteSearchScreen extends StatefulWidget {
  const NoteSearchScreen({Key? key}) : super(key: key);

  @override
  State<NoteSearchScreen> createState() => _NoteSearchScreenState();
}

class _NoteSearchScreenState extends State<NoteSearchScreen> {
  late final NoteSearchCubit _noteCubit;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _noteCubit = NoteSearchCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _noteCubit,
        child: BlocBuilder<NoteSearchCubit, NoteSearchSate>(
          buildWhen: (previous, current) =>
              previous.statusLoadAll != current.statusLoadAll,
          builder: (context, state) {
            if (kDebugMode) {
              print(state.listNote?.length.toString());
            }
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.mineShaftApprox,
              child: state.statusLoadAll == LoadingStatus.loading
                  ? _buildLoading()
                  : SafeArea(
                      child: state.listNote?.isEmpty ?? true
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                appHomeBar(),
                                const Spacer(
                                  flex: 1,
                                ),
                                state.statusLoadAll == LoadingStatus.init
                                    ? const SizedBox()
                                    : searchNotFound(),
                                const Spacer(
                                  flex: 2,
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                appHomeBar(),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: ListView.separated(
                                      itemCount: state.listNote?.length ?? 0,
                                      scrollDirection: Axis.vertical,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                          height: 23,
                                        );
                                      },
                                      itemBuilder: (context, index) {
                                        int color =
                                            state.listNote?[index].color ?? 0;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25),
                                          child: InkWell(
                                            onTap: () async {
                                              final result =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NoteDetailScreen(
                                                    id: state.listNote?[index]
                                                            .id ??
                                                        0,
                                                  ),
                                                ),
                                              );
                                              if (result == true) {
                                                if (!mounted) return;
                                                Navigator.of(context).pop(true);
                                              }
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 45,
                                                vertical: 25,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color(color),
                                              ),
                                              child: Text(
                                                state.listNote?[index].title ??
                                                    "",
                                                style: AppTextStyles
                                                    .blackS12Medium,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
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

  Widget searchNotFound() {
    return Column(
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
        style: AppTextStyles.silverS20Medium,
        textInputAction: TextInputAction.done,
        onSubmitted: (value) {
          _noteCubit.searchNote(value);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: InkWell(
            onTap: () {
              _searchController.text = "";
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

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
