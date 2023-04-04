import 'package:flutter/material.dart';
import 'package:training_newwave/exercise5/screen1.dart';
import 'package:training_newwave/exercise5/screen2.dart';
import 'package:training_newwave/exercise5/screen3.dart';

// ignore: must_be_immutable
class Screen4 extends StatefulWidget {
  TextEditingController passScreen1 = TextEditingController();
  TextEditingController passScreen2 = TextEditingController();
  TextEditingController passScreen3 = TextEditingController();

  Screen4({
    Key key,
    this.passScreen1,
    this.passScreen2,
    this.passScreen3,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StatelessScreen4();
  }
}

class StatelessScreen4 extends State<Screen4> {

  @override
  Widget build(BuildContext context) {

    var key1 = widget.passScreen1?.text;
    var key2 = widget.passScreen2?.text;
    var key3 = widget.passScreen3?.text;


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black],
          ),
          image: DecorationImage(
            image: AssetImage(
              'assets/images/sceen4.png',
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
                  tileMode: TileMode.mirror,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 86, right: 86, top: 250),
                  child: Image(
                    image: AssetImage("assets/images/Marvel_Logo.png"),
                  ),
                ),
                const SizedBox(height: 20),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55),
                  child: Text(
                    "Key1: $key1\nKey2: $key2\nKey3: $key3",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
                  onPressed: () {
                    if(key1.isEmpty){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Screen1()));
                    }
                    if(key2.isEmpty){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Screen2(
                                passScreen1: widget.passScreen1,
                                passScreen2: widget.passScreen2,
                                passScreen3: widget.passScreen3,
                              )));
                    }
                    if(key3.isEmpty){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Screen3(
                                passScreen1: widget.passScreen1,
                                passScreen2: widget.passScreen2,
                                passScreen3: widget.passScreen3,
                              )));
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
