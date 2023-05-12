import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_constant.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/model/detail_movie_entity.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/movie_app/movie_with_provider/movie_detail/movie_detail_provider.dart';
import 'package:training_newwave/movie_app/widget/action_movie_detail_widget.dart';
import 'package:training_newwave/movie_app/widget/list_cast_widget.dart';
import 'package:training_newwave/movie_app/widget/loading_widget.dart';

class MovieDetailProvider extends StatefulWidget {
  final int id;

  const MovieDetailProvider({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<MovieDetailProvider> createState() => _MovieDetailProviderState();
}

class _MovieDetailProviderState extends State<MovieDetailProvider> {
  int lengthListCastMore = 0;
  bool isBottomSheetShowing = true;
  late DetailProvider detailProvider;

  @override
  void initState() {
    detailProvider = Provider.of<DetailProvider>(context, listen: false);
    super.initState();
    detailProvider.getDetailMovie(widget.id);
    detailProvider.getListCast(widget.id);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        showBottomSheet();
      },
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
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
                  Selector<DetailProvider, LoadingStatus>(
                    selector: (_, provider) => provider.loadDetailStatus,
                    builder: (context, loadDetailStatus, child) {
                      return loadDetailStatus == LoadingStatus.loading
                          ? Flexible(
                              child: Text(
                                detailProvider.detailMovie.title ?? "",
                                textAlign: TextAlign.center,
                                style: AppTextStyles.whiteS64Bold,
                              ),
                            )
                          : const SizedBox();
                    },
                  ),
                  Selector<DetailProvider, LoadingStatus>(
                    selector: (_, provider) => provider.loadDetailStatus,
                    builder: (context, loadDetailStatus, child) {
                      return loadDetailStatus == LoadingStatus.success
                          ? Text(
                              Provider.of<DetailProvider>(context,
                                          listen: false)
                                      .detailMovie
                                      .tagline ??
                                  "",
                              style: AppTextStyles.white50S18Medium,
                            )
                          : const SizedBox();
                    },
                  ),
                  Selector<DetailProvider, LoadingStatus>(
                      selector: (_, provider) => provider.loadDetailStatus,
                      builder: (context, loadDetailStatus, child) {
                        return ActionMovieDetailWidget(
                          detailMovie: detailProvider.detailMovie,
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Center(
                      child: Selector<DetailProvider, LoadingStatus>(
                        selector: (_, provider) => provider.loadDetailStatus,
                        builder: (context, loadDetailStatus, child) {
                          return loadDetailStatus == LoadingStatus.loading
                              ? const SizedBox()
                              : ReadMoreText(
                                  detailProvider.detailMovie.overview ?? '',
                                  trimLines: 3,
                                  colorClickableText: Colors.lightBlueAccent,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'More',
                                  trimExpandedText: 'Less',
                                  textAlign: TextAlign.start,
                                  style: AppTextStyles.white75S12Medium,
                                );
                        },
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
                  Selector<DetailProvider, LoadingStatus>(
                    selector: (_, provider) => provider.loadCastStatus,
                    builder: (context, loadCastStatus, child) {
                      return loadCastStatus == LoadingStatus.loading
                          ? const SizedBox()
                          : ListCastWidget(
                              listCast: detailProvider.listCast,
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<DetailProvider, LoadingStatus>(
      selector: (_, provider) => provider.loadDetailStatus,
      builder: (context, loadDetailStatus, child) {
        return loadDetailStatus == LoadingStatus.success
            ? Scaffold(
                body: Stack(
                  children: [
                    CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      imageUrl: AppConstant.baseImage +
                          (Provider.of<DetailProvider>(context, listen: false)
                                  .detailMovie
                                  .posterPath ??
                              ""),
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
                ),
              )
            : const LoadingWidget();
      },
    );
  }
}
