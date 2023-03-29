import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyStatefulWidget extends StatefulWidget{
  const MyStatefulWidget({super.key});

  @override
  State<StatefulWidget> createState() {
      return MyStatefulWidget_State();
  }
}

class MyStatefulWidget_State extends State<MyStatefulWidget>{

  var value = "Change text";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test Statefull",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue ,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
           children: [
             Text(value),
             ElevatedButton(
               style: ElevatedButton.styleFrom(
                 minimumSize: const Size(240, 80),
               ),
               onPressed: () {
                 setState(() {
                   value = "Change text success";
                 });
               },
               child:const Text("Change text" , style: TextStyle(fontSize: 28)) ,
             )
           ],

          )
        ),
      ),
    );
  }

}