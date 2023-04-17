import 'package:flutter/cupertino.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/model/popular_entity.dart';

class Indicator extends StatelessWidget {
  final List<Movie> listMovie;
  final int currentPos;
  const Indicator({
    Key? key,
    required this.listMovie,
    required this.currentPos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators(listMovie.length, currentPos),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(
      imagesLength,
      (index) {
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
    );
  }
}
