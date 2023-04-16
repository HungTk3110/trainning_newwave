import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_constant.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/movie_app/blocpattern/movie_detail_bloc.dart';
import 'package:training_newwave/movie_app/blocpattern/movie_detail_event.dart';
import 'package:training_newwave/movie_app/widget/item_cast.dart';

import '../blocpattern/movie_detail_status.dart';

// ignore: must_be_immutable
class MovieDetailBlocPattern extends StatefulWidget {
  final int id;

  const MovieDetailBlocPattern({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  State<MovieDetailBlocPattern> createState() => _MovieDetailBlocPatternState();
}

class _MovieDetailBlocPatternState extends State<MovieDetailBlocPattern> {
  bool isBottomSheetShowing = true;
  MovieDetailBloc movieDetailBloc;

  @override
  void initState() {
    super.initState();
    movieDetailBloc = MovieDetailBloc(id: widget.id);
    movieDetailBloc.add(MovieDetailFetched());
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
        return BlocProvider(
          create: (_) => movieDetailBloc,
          child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
              builder: (context, state) {
            if (state is MovieDetailInitial || state is MovieDetailLoading) {
              return _buildLoading();
            } else if (state is MovieDetailLoaded) {
              return WillPopScope(
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
                            state.detailMovie.title,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.whiteS64Bold,
                          ),
                        ),
                        Text(
                          state.detailMovie.tagline,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                height: 24,
                                margin: const EdgeInsets.only(left: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.ripeLemon,
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SvgPicture.asset(
                                        AppVectors.icImdb,
                                      ),
                                      Text(
                                        state.detailMovie.voteAverage
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
                              state.detailMovie.overview,
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
                              itemCount: state.autogenerated.cast.length - 4 < 1
                                  ? state.autogenerated.cast.length
                                  : 5,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 1);
                              },
                              itemBuilder: (context, index) {
                                if (index == 4 &&
                                    state.autogenerated.cast.length - 4 > 0) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: AppColors.white20,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "+ ${state.autogenerated.cast.length - 4}",
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
                                    listCast: state.autogenerated.cast,
                                    cast: state.autogenerated.cast[index],
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
            }
            return const SizedBox();
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => movieDetailBloc,
      child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading || state is MovieDetailInitial) {
            return _buildLoading();
          } else if (state is MovieDetailLoaded) {
            return Scaffold(
              body: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: CachedNetworkImage(
                  imageUrl:
                      AppConstant.baseImage + state.detailMovie.posterPath,
                  fit: BoxFit.fill,
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

Widget _buildLoading() => const Center(child: CircularProgressIndicator());
