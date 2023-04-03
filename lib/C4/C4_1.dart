import 'package:flutter/material.dart';

import '../model/C4b1_entity.dart';

class TrainingC4_1 extends StatelessWidget {
  List<C4b1> list = [
    C4b1("FAQ", "assets/images/FAQ.png"),
    C4b1("Contact Us", "assets/images/Group.png"),
    C4b1("Terms & Conditions", "assets/images/terms.png")
  ];


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
                        leading: Image.asset(list[index].assetImage),
                        title: Text(list[index].title , style: const TextStyle(color: Colors.grey),),
                      ),
                    );
              }),
        ),
      ),
    );
  }
}

