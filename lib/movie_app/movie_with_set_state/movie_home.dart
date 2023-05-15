import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/model/movie_collection_entity.dart';
import 'package:training_newwave/model/popular_entity.dart';
import 'package:training_newwave/movie_app/networks/api_service.dart';
import 'package:training_newwave/movie_app/widget/app_bar_movie.dart';
import 'package:training_newwave/movie_app/widget/bottom_nav_bar.dart';
import 'package:training_newwave/movie_app/widget/indicator.dart';
import 'package:training_newwave/movie_app/widget/list_category_widget.dart';
import 'package:training_newwave/movie_app/widget/loading_widget.dart';
import 'package:training_newwave/movie_app/widget/search_movie_widget.dart';
import 'package:training_newwave/movie_app/widget/text_mostpopular_widget.dart';
import 'package:training_newwave/movie_app/widget/text_upcoming_widget.dart';

import '../widget/image_carouseslide.dart';

class MovieHome extends StatefulWidget {
  const MovieHome({Key? key}) : super(key: key);

  @override
  State<MovieHome> createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHome> {
  int currentPage = 0;
  int currentPosTop = 0;
  int currentPosBottom = 0;
  List<Movie> listMovies = [];
  List<MovieCollection> listCollection = [];

  @override
  void initState() {
    super.initState();
    listCollection = listCollectionEntity;
    fetchListMovie();
  }

  void fetchListMovie() async {
    final result = await ApiService.fetchPopular();
    setState(() {
      listMovies = result.results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onPageChange: (value) {
          setState(() {
            currentPage = value;
          });
        },
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
                    listMovie: listMovies,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 17,
                    bottom: 20,
                  ),
                  child: Indicator(
                      listMovie: listMovies, currentPos: currentPosTop),
                ),
                ListCategoryWidget(
                  listCollection: listCollection,
                ),
                const TextUpcomingWidget(),
                slideShowBottom(listMovies),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 18,
                    bottom: 20,
                  ),
                  child: Indicator(
                      listMovie: listMovies, currentPos: currentPosBottom),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget slideShowTop({
    required List<Movie> listMovie,
  }) {
    return listMovie.isEmpty
        ? const LoadingWidget()
        : CarouselSlider.builder(
            itemCount: listMovie.length,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentPosTop = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return MyImageView(
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
        ? const LoadingWidget()
        : CarouselSlider.builder(
            itemCount: list.length,
            options: CarouselOptions(
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentPosBottom = index;
                });
              },
              viewportFraction: 0.5,
            ),
            itemBuilder: (context, index, realIndex) {
              return MyImageView(
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
