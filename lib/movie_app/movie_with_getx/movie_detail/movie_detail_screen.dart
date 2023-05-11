import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_constant.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/movie_app/movie_with_getx/movie_detail/movie_detail_controller.dart';
import 'package:training_newwave/movie_app/widget/action_movie_detail_widget.dart';
import 'package:training_newwave/movie_app/widget/list_cast_widget.dart';
import 'package:training_newwave/movie_app/widget/loading_widget.dart';

class MovieDetailGetX extends StatefulWidget {
  final int id;

  const MovieDetailGetX({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<MovieDetailGetX> createState() => _MovieDetailGetXState();
}

class _MovieDetailGetXState extends State<MovieDetailGetX> {
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
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            Navigator.pop(context);
            return true;
          },
          child: GetX<MovieDetailController>(
            init: MovieDetailController(id: widget.id),
            builder: (controller) {
              return controller.loadCast.value == LoadingStatus.loading &&
                      controller.loadDetail.value == LoadingStatus.loading
                  ? const LoadingWidget()
                  : Container(
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
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 12),
                              child: SvgPicture.asset(
                                AppVectors.icLine2,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                controller.detailMovie.value.title ?? "",
                                textAlign: TextAlign.center,
                                style: AppTextStyles.whiteS64Bold,
                              ),
                            ),
                            Text(
                              controller.detailMovie.value.tagline ?? "",
                              style: AppTextStyles.white50S18Medium,
                            ),
                            ActionMovieDetailWidget(
                              detailMovie: controller.detailMovie.value,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Center(
                                child: Text(
                                  controller.detailMovie.value.overview ?? "",
                                  maxLines: 3,
                                  textAlign: TextAlign.start,
                                  style: AppTextStyles.white75S12Medium,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            ListCastWidget(
                              listCast: controller.listCast,
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<MovieDetailController>(
        init: MovieDetailController(id: widget.id),
        builder: (controller) {
          return controller.loadDetail.value == LoadingStatus.loading
              ? const LoadingWidget()
              : Stack(
                  children: [
                    CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      imageUrl: AppConstant.baseImage +
                          (controller.detailMovie.value.posterPath ?? ""),
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      top: 54,
                      left: 50,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          AppVectors.icBackDetailMovie,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
