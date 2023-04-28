import 'package:flutter/material.dart';
import 'package:training_newwave/model/movie_collection_entity.dart';
import 'package:training_newwave/movie_app/widget/item_collection_home.dart';

class ListCategoryWidget extends StatelessWidget {
  final List<MovieCollection> listCollection;
  const ListCategoryWidget({
    Key? key,
    required this.listCollection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              child: ItemCollectionHome(
                movieCollection: listCollection[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
