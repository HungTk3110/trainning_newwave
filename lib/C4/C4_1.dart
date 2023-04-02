import 'package:flutter/material.dart';

class trainingC4_1 extends StatelessWidget {
  List<c4b1> list = [
    c4b1("FAQ", "assets/images/FAQ.png"),
    c4b1("Contact Us", "assets/images/Group.png"),
    c4b1("Terms & Conditions", "assets/images/terms.png")
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Training Newwave C4 bai 1"),
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
                        title: Text(list[index].title , style: TextStyle(color: Colors.grey),),
                      ),
                    );
              }),
        ),
      ),
    );
  }
}

class c4b1 {
  String title;
  String assetImage;

  c4b1(this.title, this.assetImage);
}
