import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/movie_collection_entity.dart';
import 'package:training_newwave/model/popular_entity.dart';
import 'package:training_newwave/movie_app/movie_with_bloc/movie_home/movie_home_cubit.dart';
import 'package:training_newwave/movie_app/widget/app_bar_movie.dart';
import 'package:training_newwave/movie_app/widget/bottom_nav_bar.dart';
import 'package:training_newwave/movie_app/widget/image_carouseslide_bloc_pattern.dart';
import 'package:training_newwave/movie_app/widget/indicator.dart';
import 'package:training_newwave/movie_app/widget/list_category_widget.dart';
import 'package:training_newwave/movie_app/widget/loading_widget.dart';
import 'package:training_newwave/movie_app/widget/search_movie_widget.dart';
import 'package:training_newwave/movie_app/widget/text_mostpopular_widget.dart';
import 'package:training_newwave/movie_app/widget/text_upcoming_widget.dart';

class MovieHomeScreen extends StatefulWidget {
  const MovieHomeScreen({Key? key}) : super(key: key);

  @override
  State<MovieHomeScreen> createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHomeScreen> {
  late final MovieHomeCubit _cubit;
  List<MovieCollection> listCollection = [];

  @override
  void initState() {
    super.initState();
    _cubit = MovieHomeCubit();
    _cubit.initData();
    listCollection = listCollectionEntity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onPageChange: (value) {},
      ),
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocBuilder<MovieHomeCubit, MovieHomeState>(
          buildWhen: (previous, current) =>
              previous.loadingStatus != current.loadingStatus,
          builder: (context, state) {
            return Container(
              width: double.infinity,
              height: double.infinity,
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
              child: state.loadingStatus == LoadingStatus.loading
                  ? const LoadingWidget()
                  : SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppBarMovie(),
                            const SearchMovieWidget(),
                            const TextMostPopularWidget(),
                            SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: slideShowTop(
                                listMovie: state.popular?.results ?? [],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 17,
                                bottom: 20,
                              ),
                              child:
                                  BlocBuilder<MovieHomeCubit, MovieHomeState>(
                                buildWhen: (previous, current) =>
                                    previous.currentPosTop !=
                                    current.currentPosTop,
                                builder: (context, state) {
                                  return Indicator(
                                    listMovie: state.popular?.results ?? [],
                                    currentPos: state.currentPosTop ?? 0,
                                  );
                                },
                              ),
                            ),
                            ListCategoryWidget(
                              listCollection: listCollection,
                            ),
                            const TextUpcomingWidget(),
                            slideShowBottom(state.popular?.results ?? []),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 18,
                                bottom: 20,
                              ),
                              child: BlocBuilder<MovieHomeCubit,
                                      MovieHomeState>(
                                  buildWhen: (previous, current) =>
                                      previous.currentPosBottom !=
                                      current.currentPosBottom,
                                  builder: (context, state) {
                                    return Indicator(
                                      listMovie: state.popular?.results ?? [],
                                      currentPos: state.currentPosBottom ?? 0,
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget slideShowTop({
    required List<Movie> listMovie,
  }) {
    return listMovie.isEmpty
        ? const SizedBox()
        : CarouselSlider.builder(
            itemCount: listMovie.length,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              reverse: false,
              onPageChanged: (index, reason) {
                _cubit.setCurrentPosTop(
                  currentPosTop: index,
                );
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return ItemCarousBlocPattern(
                movie: listMovie[index],
                height: 250.0,
                width: 360.0,
                hide: true,
              );
            },
          );
  }

  Widget slideShowBottom(List<Movie> list) {
    return list.isEmpty
        ? const SizedBox()
        : CarouselSlider.builder(
            itemCount: list.length,
            options: CarouselOptions(
              autoPlay: true,
              onPageChanged: (index, reason) {
                _cubit.setCurrentPosBottom(
                  currentPosBottom: index,
                );
              },
              viewportFraction: 0.5,
            ),
            itemBuilder: (context, index, realIndex) {
              return ItemCarousBlocPattern(
                movie: list[index],
                height: 230.0,
                width: 170.0,
                hide: false,
              );
            },
          );
  }
}

/*
* 1. Sử dụng cachenetworkImage √
* 2. Xem lại các chỗ dùng thẻ Row, column √
* 3. làm custom độ dài list cast √
* 4. Sửa lại các icon Svg lấy chưa đúng √
* 5. Back 1 lần về luôn màn home từ màn detail √
*
*
*
* 6. Chỉnh sửa style
* 7. Tối ưu lại các thẻ
* */
