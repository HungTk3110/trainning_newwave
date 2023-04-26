import 'package:flutter/material.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/model/salad_entity.dart';

class ItemListViewSalad extends StatelessWidget {
  final SaladItem saladItem;
  const ItemListViewSalad({Key? key ,required this.saladItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(saladItem.assetImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 12,
          left: 12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              child: Text(
                saladItem.title,
                style: AppTextStyles.whiteS18Bold,
                maxLines: 2,
              ),
            ),
            SizedBox(
              child: Text(
                saladItem.subtitle,
                style: AppTextStyles.whiteS12Medium,
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
