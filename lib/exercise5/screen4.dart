import 'package:flutter/material.dart';
import 'package:training_newwave/configs/app_constant.dart';

class Screen4 extends StatefulWidget {
  final String textScreen1;
  final String textScreen2;
  final String textScreen3;

  const Screen4({
    Key? key,
    required this.textScreen1,
    required this.textScreen2,
    required this.textScreen3,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StatelessScreen4();
  }
}

class StatelessScreen4 extends State<Screen4> with WidgetsBindingObserver {
  var isLogin = false;

  final containerKey = GlobalKey(debugLabel: "container-key");
  double height = 0;
  double width = 0;
  double top = 0;
  double bottom = 0;
  double left = 0;
  double right = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    // debugPrint("${containerKey.hashCode}: ${this.hashCode}");
    // debugPrint("${WidgetsBinding.instance.buildOwner!.globalKeyCount}");
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    var key1 = widget.textScreen1;
    var key2 = widget.textScreen2;
    var key3 = widget.textScreen3;

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
              AppConstant.imageExercise5_4,
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
                Padding(
                  key: containerKey,
                  padding: const EdgeInsets.only(left: 86, right: 86, top: 250),
                  child: const Image(
                    image: AssetImage(AppConstant.imageExercise5Logo),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55),
                  child: Text(
                    isLogin
                        ? "Login Success"
                        : "Key1: $key1\nKey2: $key2\nKey3: $key3",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                    side: const BorderSide(color: Colors.red),
                    minimumSize: const Size(300, 50),
                  ),
                  onPressed: () {
                    if (key1.isEmpty) {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const Screen1()));
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else if (key2.isEmpty) {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Screen2(
                      //           passScreen1: widget.passScreen1,
                      //           passScreen2: widget.passScreen2,
                      //           passScreen3: widget.passScreen3,
                      //         )));
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else if (key3.isEmpty) {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Screen3(
                      //           passScreen1: widget.passScreen1,
                      //           passScreen2: widget.passScreen2,
                      //           passScreen3: widget.passScreen3,
                      //         )));
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        isLogin = true;
                        _updateData();
                      });
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 50,
              right: 10,
              child: Text(
                "top: ${top.toInt()} \nbottom: ${bottom.toInt()} \nleft: ${left.toInt()} "
                "\nright:${right.toInt()} "
                "\nheight: ${height.toInt()} \nwidth: ${width.toInt()}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateData() {
    final renderBox =
        containerKey.currentContext?.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    setState(() {
      height = renderBox.size.height;
      width = renderBox.size.width;
      left = position.dx;
      top = position.dy;
      right = position.dx + renderBox.size.width;
      bottom = position.dy + renderBox.size.height;
    });
  }
}
