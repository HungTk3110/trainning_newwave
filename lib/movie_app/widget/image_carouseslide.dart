// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:training_newwave/configs/app_constant.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/model/popular_entity.dart';
import 'package:training_newwave/movie_app/movie_detail.dart';

class MyImageView extends StatelessWidget {
  Movie movie;
  double width;
  double height;
  bool hide = false;

  MyImageView({
    Key key,
    this.movie,
    this.height,
    this.width,
    this.hide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        //Inkwell
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
              child: CachedNetworkImage(
                imageUrl: AppConstant.baseImage + movie.posterPath,
                width: width,
                height: height,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 15,
                  bottom: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 130,
                      child: Text(
                        hide ? movie.title : "",
                        style: AppTextStyles.whiteS18Bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
