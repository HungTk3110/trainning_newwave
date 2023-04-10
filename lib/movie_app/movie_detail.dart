import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:training_newwave/configs/app_constant.dart';
import 'package:training_newwave/model/detail_movie_entity.dart';
import 'package:training_newwave/model/movie_type.dart';
import 'package:training_newwave/movie_app/networks/api_service.dart';

// ignore: must_be_immutable
class MovieDetail extends StatefulWidget {
  int id;

  MovieDetail({Key key, this.id}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  DetailMovie detailMovie;

  List<MovieType> listImage = [
    MovieType(assetImage: "assets/svg/person.svg", title: "Akaza"),
    MovieType(assetImage: "assets/svg/person.svg", title: "TV series"),
    MovieType(assetImage: "assets/svg/person.svg", title: "Movies"),
    MovieType(assetImage: "assets/svg/person.svg", title: "In Theatre"),
  ];

  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  void fetchDetail() async {
    final result = await ApiService.fetchDetail(widget.id);
    setState(
      () {
        detailMovie = result;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        showModalBottomSheet(
          context: context,
          isDismissible: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          builder: (BuildContext context) {
            return detailMovie == null
                ? const SizedBox()
                : Container(
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.red,
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
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            detailMovie.title,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 28),
                            child: Center(
                              child: Text(
                                detailMovie.originalTitle,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/imdb.svg",
                                  placeholderBuilder: (BuildContext context) =>
                                      const CircularProgressIndicator(),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/share.svg",
                                      placeholderBuilder: (BuildContext context) =>
                                          const CircularProgressIndicator(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: SvgPicture.asset(
                                        "assets/svg/Favorite.svg",
                                        placeholderBuilder: (BuildContext context) =>
                                            const CircularProgressIndicator(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Center(
                              child: Text(
                                detailMovie.overview,
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "Cast",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 6),
                                  child: Text(
                                    "see all",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: SizedBox(
                              height: 55,
                              child: ListView.separated(
                                itemCount: 4,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return const SizedBox(width: 1);
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
                        ],
                      ),
                    ),
                  );
          },
        );
      },
    );
    return detailMovie == null
        ? const SizedBox()
        : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  AppConstant.baseImage + detailMovie.posterPath,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: const SizedBox(// child: BottomSheetExample(),
                ),
          );
  }

  Widget itemCategory(MovieType movieType) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: SvgPicture.asset(
              movieType.assetImage,
              placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(),
            child: Text(
              movieType.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
