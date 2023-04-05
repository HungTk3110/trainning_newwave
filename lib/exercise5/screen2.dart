import 'package:flutter/material.dart';
import 'package:training_newwave/configs/app_constant.dart';
import 'package:training_newwave/exercise5/screen3.dart';

// ignore: must_be_immutable
class Screen2 extends StatefulWidget {
  Screen2({Key key, this.passScreen1, this.passScreen2, this.passScreen3})
      : super(key: key);

  TextEditingController passScreen1 = TextEditingController();
  TextEditingController passScreen2 = TextEditingController();
  TextEditingController passScreen3 = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return StatelessScreen2();
  }
}

class StatelessScreen2 extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
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
              AppConstant.imageExercise5_2,
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
                    image: AssetImage(AppConstant.imageExercise5Logo),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 300,
                  height: 50,
                  child:  TextField(
                    obscureText: true,
                    controller: widget.passScreen2,
                    decoration: const InputDecoration(
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
                    "Watch Online\n or \nDownload Offline",
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Screen3(
                                  passScreen1: widget.passScreen1,
                                  passScreen2: widget.passScreen2,
                                  passScreen3: widget.passScreen3,
                                )));
                  },
                  child: const Text(
                    'Continue',
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
