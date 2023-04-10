import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:training_newwave/configs/app_constant.dart';
import 'package:training_newwave/model/movie_entity.dart';
import 'package:training_newwave/model/movie_type.dart';
import 'package:training_newwave/model/popular_entity.dart';
import 'package:training_newwave/movie_app/networks/api_service.dart';

import 'movie_detail.dart';

class MovieHome extends StatefulWidget {
  const MovieHome({Key key}) : super(key: key);

  @override
  State<MovieHome> createState() => _Movie_HomeState();
}

// ignore: camel_case_types
class _Movie_HomeState extends State<MovieHome> {
  int currentPos = 0;

  List<MovieEntity> listMovie = listMovieTop();

  List<MovieType> listImage = [
    MovieType(assetImage: "assets/svg/Vector.svg", title: "Genres"),
    MovieType(assetImage: "assets/svg/tv series icon.svg", title: "TV series"),
    MovieType(assetImage: "assets/svg/Movie Roll.svg", title: "Movies"),
    MovieType(assetImage: "assets/svg/Cinema.svg", title: "In Theatre"),
  ];

  List<Movie> listMovies = [];

  @override
  void initState() {
    super.initState();
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color(0xff2B5876),
              Color(0xff4E4376),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 65,
                  right: 65,
                  top: 78,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Hello , Jane!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/svg/notfication_icon.svg",
                      placeholderBuilder: (BuildContext context) =>
                          const CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 50,
                  right: 50,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    suffixIcon: Icon(
                      Icons.keyboard_voice_outlined,
                      color: Colors.white,
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Most Popular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 150,
                child: slideShowTop(
                  listMovie: listMovies,
                  current: currentPos,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 17,
                  bottom: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: listMovie.map(
                    (url) {
                      int index = listMovie.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 2.0,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentPos == index
                              ? const Color(0xff64ABDB)
                              : const Color(0xff826EC8),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              SizedBox(
                height: 110,
                child: Center(
                  child: ListView.separated(
                    itemCount: 4,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 12);
                    },
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: itemCategory(
                          listImage[index],
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Upcoming releases",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: slideShowBottom(listMovies, currentPos),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: listMovie.map(
                  (url) {
                    int index = listMovie.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 2.0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            currentPos == index ? const Color(0xff64ABDB) : const Color(0xff826EC8),
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget slideShowTop({
    List<Movie> listMovie,
    int current,
  }) {
    return listMovie.isEmpty
        ? const SizedBox()
        : CarouselSlider.builder(
            itemCount: listMovie.length,
            options: CarouselOptions(
              autoPlay: true,
              onPageChanged: (
                index,
                reason,
              ) {
                setState(() {
                  current = index;
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

  Widget slideShowBottom(List<Movie> list, int current) {
    return list.isEmpty
        ? const SizedBox()
        : CarouselSlider.builder(
            itemCount: list.length,
            options: CarouselOptions(
              autoPlay: true,
              onPageChanged: (
                index,
                reason,
              ) {
                setState(() {
                  current = index;
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

  Widget itemCategory(MovieType movieType) {
    return Container(
      width: 70,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.white,
        ),
        borderRadius:
            const BorderRadius.all(Radius.circular(15.0) //                 <--- border radius here
                ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 31,
            height: 31,
            child: SvgPicture.asset(
              movieType.assetImage,
              placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              movieType.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class MyImageView extends StatelessWidget {
  Movie movie;
  double width;
  double height;
  bool hide = false;

  MyImageView({Key key, this.movie, this.height, this.width, this.hide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetail(
                id: movie.id,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                AppConstant.baseImage + movie.posterPath,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 15,
              left: 30,
              child: Text(
                hide ? movie.title : "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
