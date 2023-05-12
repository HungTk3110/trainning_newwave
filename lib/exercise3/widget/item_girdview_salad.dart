import 'package:flutter/material.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/model/salad_entity.dart';

class ItemGirdViewSalad extends StatelessWidget {
  final SaladItem saladItem;
  final bool isRefresh;
  const ItemGirdViewSalad({
    Key? key,
    required this.saladItem,
    required this.isRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 -
          MediaQuery.of(context).padding.horizontal,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(
            saladItem.assetImage,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Colors.transparent,
              Colors.black,
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    right: 10,
                  ),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isRefresh ? Colors.yellow : Colors.red,
                  ),
                  child: Icon(
                    isRefresh ? Icons.search : Icons.bookmark_border,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 40,
                child: Text(
                  saladItem.title,
                  style: AppTextStyles.whiteS18Bold,
                  maxLines: 2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                bottom: 10,
                top: 10,
              ),
              child: SizedBox(
                child: Text(
                  saladItem.subtitle,
                  style: AppTextStyles.whiteS12Medium,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
