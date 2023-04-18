import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_images.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/note_app/database/database_helper.dart';
import 'package:training_newwave/note_app/ui/create_notes_screen.dart';

class HomeNoteScreen extends StatefulWidget {
  const HomeNoteScreen({Key? key}) : super(key: key);

  @override
  State<HomeNoteScreen> createState() => _HomeNoteScreenState();
}

class _HomeNoteScreenState extends State<HomeNoteScreen> {
  List<Map<String, dynamic>> listNote = [];
  LoadingStatus loadingStatus = LoadingStatus.init;

  void _refreshData() async {
    final data = await DatabaseHelper.getItems();
    setState(() {
      listNote = data;
      loadingStatus = LoadingStatus.loading;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshData();
    if (listNote.isNotEmpty) {
      setState(() {
        loadingStatus = LoadingStatus.success;
      });
    } else {
      setState(() {
        loadingStatus = LoadingStatus.failure;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.mineShaftApprox,
        child: loadingStatus == LoadingStatus.init
            ? _buildLoading()
            : SafeArea(
                child: listNote.isEmpty
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
                          Padding(
                            padding: const EdgeInsets.only(top: 37),
                            child: ListView.separated(
                              itemCount: listNote.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox(
                                  width: 23,
                                );
                              },
                              itemBuilder: (context, index) {
                                int color = listNote[index]['color'];
                                return Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 45,
                                    vertical: 25,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(color),
                                  ),
                                  child: Text(
                                    listNote[index]["title"],
                                    style: AppTextStyles.blackS12Medium,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          right: 10,
          bottom: 30,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateNotesScreen(),
              ),
            );
          },
          backgroundColor: AppColors.mineShaftApprox,
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }

  Widget appHomeBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
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
