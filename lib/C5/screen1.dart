import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  const Screen1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StatefulScreen1(),
    );
  }
}

class StatefulScreen1 extends StatefulWidget {
  const StatefulScreen1({Key key}) : super(key: key);

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black],
          ),
          image: DecorationImage(
            image: AssetImage(
              'assets/images/screen1.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment(0.8, 1),
                  colors: <Color>[
                    Colors.transparent,
                    Colors.black,
                  ],
                  // Gradient from https://learnui.design/tools/gradient-generator.html
                  tileMode: TileMode.mirror,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 86  , right:  86 , top: 300),
                  child: Image(
                    image: AssetImage("assets/images/Marvel_Logo.png"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 300,
                  height: 50,
                  child: const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                 const Padding(
                   padding: EdgeInsets.symmetric(horizontal: 55),
                  child: Text(
                    "All your favourite MARVEL Movies & Series at one place",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(300, 50),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 18 , color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
