import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_constant.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/model/detail_movie_entity.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/movie_app/movie_with_bloc/movie_detail/movie_detail_cubit.dart';
import 'package:training_newwave/movie_app/widget/action_movie_detail_widget.dart';
import 'package:training_newwave/movie_app/widget/list_cast_widget.dart';
import 'package:training_newwave/movie_app/widget/loading_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;

  const MovieDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isBottomSheetShowing = true;
  late MovieDetailCubit _movieDetailCubit;

  @override
  void initState() {
    super.initState();
    _movieDetailCubit = MovieDetailCubit(id: widget.id);
    _movieDetailCubit.fetchData();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        showBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _movieDetailCubit,
      child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
        bloc: _movieDetailCubit,
        buildWhen: (previous, current) =>
            previous.loadingStatus != current.loadingStatus,
        builder: (context, state) {
          return state.loadingStatus == LoadingStatus.loading
              ? const LoadingWidget()
              : Scaffold(
                  body: Stack(
                    children: [
                      CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        imageUrl: AppConstant.baseImage +
                            (state.detailMovie?.posterPath ?? ""),
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
                );
        },
      ),
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
        return BlocProvider(
          create: (_) => _movieDetailCubit,
          child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
            bloc: _movieDetailCubit,
            buildWhen: (previous, current) =>
                previous.loadingStatus != current.loadingStatus,
            builder: (context, state) {
              if (state.loadingStatus == LoadingStatus.loading) {
                return const LoadingWidget();
              } else if (state.loadingStatus == LoadingStatus.success) {
                return WillPopScope(
                  onWillPop: () async {
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
                          Text(
                            state.detailMovie?.title ?? "",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.whiteS64Bold,
                          ),
                          Text(
                            state.detailMovie?.tagline ?? "",
                            style: AppTextStyles.white50S18Medium,
                          ),
                          ActionMovieDetailWidget(
                            detailMovie: state.detailMovie ?? DetailMovie(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: ReadMoreText(
                              state.detailMovie?.overview ?? "",
                              trimLines: 3,
                              colorClickableText: Colors.lightBlueAccent,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'More',
                              trimExpandedText: 'Less',
                              textAlign: TextAlign.start,
                              style: AppTextStyles.white75S12Medium,
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
                          ListCastWidget(
                            listCast: state.listCast ?? [],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}
