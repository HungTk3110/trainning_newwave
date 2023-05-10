import 'package:flutter/material.dart';
import 'package:training_newwave/configs/app_styles.dart';

class ItemNoteWidget extends StatelessWidget {
  final String title;
  final int color;
  const ItemNoteWidget({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 45,
        vertical: 25,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(color),
      ),
      child: Text(
        title,
        style: AppTextStyles.blackS24Medium,
      ),
    );
  }
}
