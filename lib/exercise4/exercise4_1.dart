import 'package:flutter/material.dart';
import 'package:training_newwave/model/image_exercise4_entity.dart';

// ignore: camel_case_types, must_be_immutable
class Exercise4_1 extends StatelessWidget {
  List<Image_Exercise4_Entity> list = [
    Image_Exercise4_Entity(
      title:"FAQ",
      assetImage:"assets/images/FAQ.png",
    ),
    Image_Exercise4_Entity(
      title:"Contact Us",
      assetImage:"assets/images/Group.png",
    ),
    Image_Exercise4_Entity(
      title:"Terms & Conditions",
      assetImage:"assets/images/terms.png",
    )
  ];

  Exercise4_1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Training Newwave C4 bai 1"),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: list.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  leading: Image.asset(
                    list[index].assetImage,
                  ),
                  title: Text(
                    list[index].title,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
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
