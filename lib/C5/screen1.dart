import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StatefulScreen1(),
    );
  }
}

class StatefulScreen1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StatelessScreen1();
  }
}

class StatelessScreen1 extends State<StatefulScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Image.asset(
              "assets/images/screen1.jpg",
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.45 ,
              left: MediaQuery.of(context).size.height * 0.1,
              child: Image.asset(
                "assets/images/Marvel_Logo.png",
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.6,
                alignment: Alignment.center,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.5 ,

              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),)
          ],
        ));
  }
}
