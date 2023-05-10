import 'package:flutter/material.dart';
import 'package:training_newwave/configs/app_constant.dart';
import 'package:training_newwave/exercise5/screen3.dart';

class Screen2 extends StatefulWidget {
  final String textScreen1;

  const Screen2({
    Key? key,
    required this.textScreen1,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StatelessScreen2();
  }
}

class StatelessScreen2 extends State<Screen2> {
  TextEditingController passScreen2 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                    child: TextField(
                      obscureText: true,
                      controller: passScreen2,
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
                            textScreen1: widget.textScreen1,
                            textScreen2: passScreen2.text,
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
      ),
    );
  }
}
