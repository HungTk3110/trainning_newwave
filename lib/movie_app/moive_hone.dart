import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:training_newwave/model/movie_type.dart';

class MovieHome extends StatefulWidget {
  const MovieHome({Key key}) : super(key: key);

  @override
  State<MovieHome> createState() => _Movie_HomeState();
}

// ignore: camel_case_types
class _Movie_HomeState extends State<MovieHome> {
  int currentPos = 0;
  List<String> listPaths = [
    "assets/images/deadpool.png",
    "assets/images/deadpool.png",
    "assets/images/deadpool.png",
  ];

  List<String> listPath = [
    "assets/images/Project-Power-Movie-Poster-Jamie-Foxx 1 (2).png",
    "assets/images/Project-Power-Movie-Poster-Jamie-Foxx 1 (2).png",
    "assets/images/Project-Power-Movie-Poster-Jamie-Foxx 1 (2).png",
  ];

  List<MovieType> listImage = [
    MovieType(assetImage: "assets/images/Vector.png", title: "Genres"),
    MovieType(assetImage: "assets/images/tv series icon.png", title: "TV series"),
    MovieType(assetImage: "assets/images/Movie Roll.png", title: "Movies"),
    MovieType(assetImage: "assets/images/Cinema.png", title: "In Theatre"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
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
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
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
                    IconButton(
                      icon: const ImageIcon(
                        AssetImage("assets/images/notfication_icon.png"),
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 10,
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
                  top: 10,
                  bottom: 10,
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
                child: slideShow(listPaths, currentPos),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: listPaths.map(
                      (url) {
                    int index = listPaths.indexOf(url);
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
              SizedBox(
                height: 95,
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
                        height: 95,
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
                  top: 10,
                  bottom: 10,
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
                child: slideShow(listPath, currentPos),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: listPaths.map(
                      (url) {
                    int index = listPaths.indexOf(url);
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

  Widget slideShow(List<String> list, int current) {
    return CarouselSlider.builder(
      itemCount: list.length,
      options: CarouselOptions(
          autoPlay: true,
          onPageChanged: (index,
              reason,) {
            setState(() {
              current = index;
            });
          }),
      itemBuilder: (context, index) {
        return MyImageView(list[index]);
      },
    );
  }

  Widget itemCategory(MovieType movieType) {
    return Container(
      width: 69,
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
            child: ImageIcon(
              AssetImage(movieType.assetImage),
              color: Colors.white,
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
  String imgPath;

  MyImageView(this.imgPath, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: FittedBox(
        fit: BoxFit.fill,
        child: Image.asset(imgPath),
      ),
    );
  }
}
