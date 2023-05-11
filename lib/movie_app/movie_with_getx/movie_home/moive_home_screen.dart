import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/movie_collection_entity.dart';
import 'package:training_newwave/model/popular_entity.dart';
import 'package:training_newwave/movie_app/movie_with_getx/movie_home/movie_home_controller.dart';
import 'package:training_newwave/movie_app/widget/app_bar_movie.dart';
import 'package:training_newwave/movie_app/widget/bottom_nav_bar.dart';
import 'package:training_newwave/movie_app/widget/image_carouseslide_getx.dart';
import 'package:training_newwave/movie_app/widget/indicator.dart';
import 'package:training_newwave/movie_app/widget/list_category_widget.dart';
import 'package:training_newwave/movie_app/widget/loading_widget.dart';
import 'package:training_newwave/movie_app/widget/search_movie_widget.dart';
import 'package:training_newwave/movie_app/widget/text_mostpopular_widget.dart';
import 'package:training_newwave/movie_app/widget/text_upcoming_widget.dart';

class MovieHomeGetX extends StatefulWidget {
  const MovieHomeGetX({Key? key}) : super(key: key);

  @override
  State<MovieHomeGetX> createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHomeGetX> {
  List<MovieCollection> listCollection = [];
  late MovieHomeController movieHomeController;

  @override
  void initState() {
    super.initState();
    listCollection = listCollectionEntity;
    movieHomeController = MovieHomeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onPageChange: (value) {},
      ),
      body: Container(
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
        child: SingleChildScrollView(
          child: SafeArea(
            child: GetX<MovieHomeController>(
                init: movieHomeController,
                builder: (controller) {
                  return controller.loadingStatus.value == LoadingStatus.loading
                      ? const LoadingWidget()
                      : Column(
                          children: [
                            const AppBarMovie(),
                            const SearchMovieWidget(),
                            const TextMostPopularWidget(),
                            SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: slideShowTop(
                                listMovie: controller.listMovies,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 17,
                                bottom: 20,
                              ),
                              child: Indicator(
                                  listMovie: controller.listMovies,
                                  currentPos: controller.currentPosTop.value),
                            ),
                            ListCategoryWidget(
                              listCollection: listCollection,
                            ),
                            const TextUpcomingWidget(),
                            slideShowBottom(controller.listMovies),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 18,
                                bottom: 20,
                              ),
                              child: Indicator(
                                  listMovie: controller.listMovies,
                                  currentPos:
                                      controller.currentPosBottom.value),
                            )
                          ],
                        );
                }),
          ),
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
                setState(() {
                  movieHomeController.setCurrentPosTop(
                    currentPos: index,
                  );
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return ItemCarousGetX(
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
                setState(() {
                  movieHomeController.setCurrentPosBottom(
                    currentPos: index,
                  );
                });
              },
              viewportFraction: 0.5,
            ),
            itemBuilder: (context, index, realIndex) {
              return ItemCarousGetX(
                movie: list[index],
                height: 230.0,
                width: 170.0,
                hide: false,
              );
            },
          );
  }
}
// ignore: must_be_immutable

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
