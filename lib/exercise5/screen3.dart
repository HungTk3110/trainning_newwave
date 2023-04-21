import 'package:flutter/material.dart';
import 'package:training_newwave/configs/app_constant.dart';
import 'package:training_newwave/exercise5/screen4.dart';

class Screen3 extends StatefulWidget {
  final String textScreen1;
  final String textScreen2;

  const Screen3({
    Key? key,
    required this.textScreen1,
    required this.textScreen2,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StatelessScreen3();
  }
}

class StatelessScreen3 extends State<Screen3> {
  TextEditingController passScreen3 = TextEditingController();

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
              AppConstant.imageExercise5_3,
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
                  child: TextField(
                    obscureText: true,
                    controller: passScreen3,
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
                    "Create profiles for\n diffrent members &\n get personalised\n recommendations",
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
                        builder: (context) => Screen4(
                          textScreen1: widget.textScreen1,
                          textScreen2: widget.textScreen2,
                          textScreen3: passScreen3.text,
                        ),
                      ),
                    );
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
