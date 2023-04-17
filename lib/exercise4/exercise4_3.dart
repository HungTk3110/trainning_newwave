// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../model/image_exercise4_entity.dart';

// ignore: camel_case_types
class Exercise4_3 extends StatelessWidget {
  List<Image_Exercise4_Entity> list = [
    Image_Exercise4_Entity(
      title: "FAQ",
      assetImage: "assets/svg/FAQ.svg",
    ),
    Image_Exercise4_Entity(
      title: "Contact Us",
      assetImage: "assets/svg/Contact.svg",
    ),
    Image_Exercise4_Entity(
      title: "Terms & Conditions",
      assetImage: "assets/svg/terms.svg",
    )
  ];

  Exercise4_3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Training Newwave C4 bai 3"),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: list.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  leading: SvgPicture.asset(
                    list[index].assetImage,
                    placeholderBuilder: (BuildContext context) =>
                        const CircularProgressIndicator(),
                  ),
                  title: Text(
                    list[index].title,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
