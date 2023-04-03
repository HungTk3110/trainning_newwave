import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../model/C4b1_entity.dart';


class C4b3 extends StatelessWidget {
  List<C4b1> list = [
    C4b1("FAQ", "assets/svg/FAQ.svg"),
    C4b1("Contact Us", "assets/svg/Contact.svg"),
    C4b1("Terms & Conditions", "assets/svg/terms.svg")
  ];

  C4b3({super.key});

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
                        leading: SvgPicture.asset(list[index].assetImage,
                          placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(),),
                        title: Text(list[index].title , style: const TextStyle(color: Colors.grey),),
                      ),
                    );
              }),
        ),
      ),
    );
  }
}

