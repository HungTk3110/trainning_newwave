import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_images.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/note_app/bloc/note_cubit.dart';
import 'package:training_newwave/note_app/ui/create_notes_screen.dart';
import 'package:training_newwave/note_app/ui/detaill_notes_screen.dart';

class HomeNoteScreen extends StatefulWidget {
  const HomeNoteScreen({Key? key}) : super(key: key);

  @override
  State<HomeNoteScreen> createState() => _HomeNoteScreenState();
}

class _HomeNoteScreenState extends State<HomeNoteScreen> {
  late final NoteCubit _noteCubit;

  @override
  void initState() {
    super.initState();
    _noteCubit = NoteCubit();
    _noteCubit.getAllNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _noteCubit,
        child: BlocBuilder<NoteCubit, NoteSate>(
          buildWhen: (previous, current) => previous.loadingStatus != current.loadingStatus,
          builder: (context, state) {
            if (kDebugMode) {
              print(state.listNote?.length.toString());
            }
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.mineShaftApprox,
              child: state.loadingStatus == LoadingStatus.loading
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
                                Image.asset(
                                  AppImages.imgNoteNull,
                                ),
                                Text(
                                  "Create your first note !",
                                  style: AppTextStyles.whiteS20Medium,
                                ),
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
                                  child: ListView.separated(
                                    itemCount: state.listNote?.length ?? 0,
                                    scrollDirection: Axis.vertical,
                                    physics: const AlwaysScrollableScrollPhysics(),
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
                                          key: UniqueKey(),
                                          confirmDismiss: (_) async {
                                            return await openDialogDelete(
                                                context: context,
                                                id: state.listNote?[index].id ?? 0);
                                          },
                                          direction: DismissDirection.horizontal,
                                          background: Container(
                                            margin: const EdgeInsets.only(left: 25),
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
                                            onTap: () => {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => DetailNotesScreen(
                                                      id: state.listNote?[index].id ?? 0),
                                                ),
                                              ),
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 45,
                                                vertical: 25,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Color(color),
                                              ),
                                              child: Text(
                                                state.listNote?[index].title ?? "",
                                                style: AppTextStyles.blackS12Medium,
                                              ),
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
                builder: (context) => const CreateNotesScreen(),
              ),
            );

            if (result is bool) {
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
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 18,
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
            child: SvgPicture.asset(
              AppVectors.icSearchNote,
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

  Future openDialogDelete({required BuildContext context, required int id}) {
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppVectors.icNoteWarning,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  "Delete this note?",
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
                        _noteCubit.deleteNote(id);
                        Navigator.pop(context);
                      },
                      child: Text('Delete', style: AppTextStyles.whiteS18Medium),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.jungleGreen, // foreground
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel', style: AppTextStyles.whiteS18Medium),
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

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
