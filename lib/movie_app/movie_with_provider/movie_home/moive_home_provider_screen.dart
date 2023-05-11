import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/movie_collection_entity.dart';
import 'package:training_newwave/model/popular_entity.dart';
import 'package:training_newwave/movie_app/movie_with_provider/movie_home/movie_home_provider.dart';
import 'package:training_newwave/movie_app/widget/app_bar_movie.dart';
import 'package:training_newwave/movie_app/widget/bottom_nav_bar.dart';
import 'package:training_newwave/movie_app/widget/image_carouseslide_provider.dart';
import 'package:training_newwave/movie_app/widget/indicator.dart';
import 'package:training_newwave/movie_app/widget/list_category_widget.dart';
import 'package:training_newwave/movie_app/widget/loading_widget.dart';
import 'package:training_newwave/movie_app/widget/search_movie_widget.dart';
import 'package:training_newwave/movie_app/widget/text_mostpopular_widget.dart';
import 'package:training_newwave/movie_app/widget/text_upcoming_widget.dart';

class MovieHomeProvider extends StatefulWidget {
  const MovieHomeProvider({Key? key}) : super(key: key);

  @override
  State<MovieHomeProvider> createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHomeProvider> {
  int currentPosTop = 0;
  int currentPosBottom = 0;
  List<MovieCollection> listCollection = [];
  late HomeProvider homeProvider;

  @override
  void initState() {
    super.initState();
    listCollection = listCollectionEntity;
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getAllMovies();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBarMovie(),
                const SearchMovieWidget(),
                const TextMostPopularWidget(),
                SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: Selector<HomeProvider, LoadingStatus>(
                    selector: (_, provider) => provider.loadListPopularStatus,
                    builder: (context, loadListPopularStatus, child) {
                      return loadListPopularStatus == LoadingStatus.loading
                          ? const SizedBox()
                          : slideShowTop(
                              listMovie: homeProvider.listMovies,
                            );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 17,
                    bottom: 20,
                  ),
                  child: Selector<HomeProvider, LoadingStatus>(
                    selector: (_, provider) => provider.loadListPopularStatus,
                    builder: (context, loadListPopularStatus, child) {
                      return loadListPopularStatus == LoadingStatus.loading
                          ? const SizedBox()
                          : Indicator(
                              listMovie: homeProvider.listMovies,
                              currentPos: currentPosTop);
                    },
                  ),
                ),
                ListCategoryWidget(
                  listCollection: listCollection,
                ),
                const TextUpcomingWidget(),
                Selector<HomeProvider, LoadingStatus>(
                  selector: (_, provider) => provider.loadListPopularStatus,
                  builder: (context, loadListPopularStatus, child) {
                    return homeProvider.listMovies.isEmpty
                        ? const LoadingWidget()
                        : slideShowBottom(homeProvider.listMovies);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 18,
                    bottom: 20,
                  ),
                  child: Selector<HomeProvider, LoadingStatus>(
                    selector: (_, provider) => provider.loadListPopularStatus,
                    builder: (context, loadListPopularStatus, child) {
                      return loadListPopularStatus == LoadingStatus.loading
                          ? const SizedBox()
                          : Indicator(
                              listMovie: homeProvider.listMovies,
                              currentPos: currentPosBottom);
                    },
                  ),
                ),
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
        ? const SizedBox()
        : CarouselSlider.builder(
            itemCount: listMovie.length,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              reverse: false,
              onPageChanged: (index, reason) {
                homeProvider.setCurrentPosTop(
                  currentPos: index,
                );
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return ItemCarousProvider(
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
                homeProvider.setCurrentPosBottom(
                  currentPos: index,
                );
              },
              viewportFraction: 0.5,
            ),
            itemBuilder: (context, index, realIndex) {
              return ItemCarousProvider(
                movie: list[index],
                height: 230.0,
                width: 170.0,
                hide: false,
              );
            },
          );
  }
}
