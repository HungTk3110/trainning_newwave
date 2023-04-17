import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class MyStatefulWidget extends StatefulWidget{
//   const MyStatefulWidget({super.key});
//
//   @override
//   State<StatefulWidget> createState() {
//       return MyStatefulWidget_State();
//   }
// }
//
// class MyStatefulWidget_State extends State<MyStatefulWidget>{
//
//   var value = "Change text";
//   var boolChangeTexx = true;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Test Statefull",
//       theme: ThemeData(
//         primarySwatch: Colors.lightBlue ,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: Scaffold(
//         appBar: AppBar(),
//         body: Center(
//           child: Column(
//            children: [
//              boolChangeTexx ? Text(value) : Text("Change text success",),
//              ElevatedButton(
//                style: ElevatedButton.styleFrom(
//                  minimumSize: const Size(240, 80),
//                ),
//                onPressed: () {
//                  setState(() {
//                    boolChangeTexx =  false;
//                  });
//                },
//                child:const Text("Change text" , style: TextStyle(fontSize: 28)) ,
//              )
//            ],
//
//           )
//         ),
//       ),
//     );
//   }
//
// }
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
