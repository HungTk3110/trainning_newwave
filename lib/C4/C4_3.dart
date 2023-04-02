import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class C4b3 extends StatelessWidget {
  List<c4b1> list = [
    c4b1("FAQ", "assets/svg/FAQ.svg"),
    c4b1("Contact Us", "assets/svg/Contact.svg"),
    c4b1("Terms & Conditions", "assets/svg/terms.svg")
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Training Newwave C4 bai 3"),
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
                          placeholderBuilder: (BuildContext context) => Container(
                              child: const CircularProgressIndicator()),),
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
