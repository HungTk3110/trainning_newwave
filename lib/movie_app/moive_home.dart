import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/model/movie_collection_entity.dart';
import 'package:training_newwave/model/popular_entity.dart';
import 'package:training_newwave/movie_app/networks/api_service.dart';

import 'widget/image_carouseslide.dart';

class MovieHome extends StatefulWidget {
  const MovieHome({Key key}) : super(key: key);

  @override
  State<MovieHome> createState() => _Movie_HomeState();
}

// ignore: camel_case_types
class _Movie_HomeState extends State<MovieHome> {
  int currentPos = 0;
  List<Movie> listMovies = [];
  List<MovieCollection> listCollection = [];

  @override
  void initState() {
    super.initState();
    fetchListMovie();
  }

  void fetchListMovie() async {
    final result = await ApiService.fetchPopular();
    setState(() {
      listMovies = result.results;
      listCollection = listCollectionEntity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 65,
                    right: 65,
                    top: 24,
                  ),
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: AppTextStyles.whiteS18Medium,
                          children: <TextSpan>[
                            const TextSpan(text: "Hello, "),
                            TextSpan(
                              text: "jane!",
                              style: AppTextStyles.whiteS18Bold,
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        AppVectors.icNotification,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                    left: 50,
                    right: 50,
                  ),
                  padding: const EdgeInsets.only(
                    top: 14,
                    right: 17,
                    bottom: 14,
                  ),
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.white20,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: SvgPicture.asset(
                        AppVectors.icSearch,
                      ),
                      hintText: "Search",
                      contentPadding: const EdgeInsets.only(bottom: 10),
                      hintStyle: AppTextStyles.white50S18Medium,
                      suffixIcon: SizedBox(
                        width: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              AppVectors.icLine1,
                            ),
                            SvgPicture.asset(
                              AppVectors.icVoice,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 50,
                    top: 26,
                    bottom: 15,
                  ),
                  child: Text(
                    "Most Popular",
                    style: AppTextStyles.whiteS18Bold,
                  ),
                ),
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
                  child: indicator(listMovie: listMovies),
                ),
                SizedBox(
                  height: 110,
                  child: Center(
                    child: ListView.separated(
                      itemCount: listCollection.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 12);
                      },
                      itemBuilder: (context, index) {
                        return SizedBox(
                          child: itemCategory(
                            listCollection[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 50,
                    top: 26,
                    bottom: 15,
                  ),
                  child: Text(
                    "Upcoming releases",
                    style: AppTextStyles.whiteS18Bold,
                  ),
                ),
                SizedBox(
                  child: slideShowBottom(listMovies),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 18,
                    bottom: 20,
                  ),
                  child: indicator(listMovie: listMovies),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget slideShowTop({
    List<Movie> listMovie,
  }) {
    return listMovie.isEmpty
        ? const SizedBox()
        : CarouselSlider.builder(
            itemCount: listMovie.length,
            options: CarouselOptions(
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentPos = index;
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

  Widget indicator({
    List<Movie> listMovie,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: listMovies.map(
        (url) {
          int index = listMovies.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 2.0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  currentPos == index ? AppColors.havelockBlue : AppColors.havelockBlue30,
                  currentPos == index ? AppColors.blueMarguerite : AppColors.blueMarguerite30,
                ],
              ),
            ),
          );
        },
      ).toList(),
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
                  currentPos = index;
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

  Widget itemCategory(MovieCollection movieType) {
    return Container(
      width: 70,
      height: 95,
      decoration: BoxDecoration(
        color: AppColors.white20,
        border: Border.all(
          width: 1,
          color: AppColors.white20,
        ),
        borderRadius:
            const BorderRadius.all(Radius.circular(15.0) //                 <--- border radius here
                ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            child: SvgPicture.asset(
              movieType.assetImage,
              fit: BoxFit.cover,
              placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 15,
            ),
            child: Text(movieType.title, style: AppTextStyles.whiteS10Medium),
          )
        ],
      ),
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
