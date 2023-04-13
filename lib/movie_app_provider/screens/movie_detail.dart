import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_constant.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/movie_app/widget/item_cast.dart';
import 'package:training_newwave/movie_app_provider/provider/detail_provider.dart';

// ignore: must_be_immutable
class MovieDetail extends StatefulWidget {
  final int id;

  const MovieDetail({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  int lengthListCastMore = 0;
  bool isBottomSheetShowing = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        showBottomSheet();
      },
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      useRootNavigator: true,
      barrierColor: Colors.black.withAlpha(1),
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Selector<DetailProvider, LoadingStatus>(
          selector: (_, provider) => provider.loadDetailStatus,
          builder: (context, loadDetailStatus, child) {
            return loadDetailStatus == LoadingStatus.loading
                ? SizedBox()
                : WillPopScope(
                    onWillPop: () async {
                      debugPrint("isBottomSheetShowingaaa: $isBottomSheetShowing");
                      isBottomSheetShowing = false;
                      Navigator.pop(context);
                      Navigator.pop(context);
                      return true;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[
                            AppColors.sanJuan,
                            AppColors.eastBay,
                          ],
                          tileMode: TileMode.mirror,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 12),
                              child: SvgPicture.asset(
                                AppVectors.icLine2,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                Provider.of<DetailProvider>(context, listen: false)
                                    .detailMovie
                                    .title,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.whiteS64Bold,
                              ),
                            ),
                            Text(
                              Provider.of<DetailProvider>(context, listen: false)
                                  .detailMovie
                                  .tagline,
                              style: AppTextStyles.white50S18Medium,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 27),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 62,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.coldPurple30,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Action",
                                        style: AppTextStyles.whiteS12bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    height: 24,
                                    margin: const EdgeInsets.only(left: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.ripeLemon,
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          SvgPicture.asset(
                                            AppVectors.icImdb,
                                          ),
                                          Text(
                                            Provider.of<DetailProvider>(context, listen: false)
                                                .detailMovie
                                                .voteAverage
                                                .toString(),
                                            style: AppTextStyles.blackS12bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset(
                                    AppVectors.icShare,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: SvgPicture.asset(
                                      AppVectors.icFavorite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Center(
                                child: Text(
                                  Provider.of<DetailProvider>(context, listen: false)
                                      .detailMovie
                                      .overview,
                                  maxLines: 3,
                                  textAlign: TextAlign.start,
                                  style: AppTextStyles.white75S12Medium,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Cast",
                                    style: AppTextStyles.whiteS18Bold,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      "See all",
                                      style: AppTextStyles.whiteS12Medium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: SizedBox(
                                height: 122,
                                child: ListView.separated(
                                  itemCount: Provider.of<DetailProvider>
                                    (context, listen: false).listCast.length -4 < 1 ? Provider
                                      .of<DetailProvider>
                                    (context, listen: false).listCast.length : 5,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 1);
                                  },
                                  itemBuilder: (context, index) {
                                    if (index == 4 && lengthListCastMore > 0) {
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: AppColors.white20,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "+ $lengthListCastMore",
                                                style: AppTextStyles.whiteS18Medium,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8),
                                            child: Text('',
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: AppTextStyles.whiteS8Medium),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return ItemCast(
                                        listCast:
                                            Provider.of<DetailProvider>(context, listen: false)
                                                .listCast,
                                        cast: Provider.of<DetailProvider>(context, listen: false)
                                            .listCast[index],
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        );
      },
    );
  }

  // // void fetchDetail() async {
  // //   // final result = await ApiService.fetchDetail(widget.id);
  // //   // final resultCast = await ApiService.fetchAutogenerated(widget.id);
  // //
  // //   setState(
  // //     () {
  // //       detailMovie = result;
  // //       listCast = resultCast.cast;
  // //       lengthListCastMore = resultCast.cast.length - 4;
  // //     },
  // //   );
  //
  //   WidgetsBinding.instance.addPostFrameCallback(
  //     (timeStamp) {
  //       showBottomSheet();
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Selector<DetailProvider, LoadingStatus>(
      selector: (_, provider) => provider.loadDetailStatus,
      builder: (context, loadDetailStatus, child) {
        return loadDetailStatus == LoadingStatus.loading
            ? SizedBox()
            : Scaffold(
                body: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CachedNetworkImage(
                    imageUrl: AppConstant.baseImage +
                        Provider.of<DetailProvider>(context, listen: false).detailMovie.posterPath,
                    fit: BoxFit.fill,
                  ),
                ),
              );
      },
    );
  }
}
