import 'dart:async';

import 'package:intl/intl.dart'; // for date format

Future<void> getUserOrder() async {
   Timer.periodic(const Duration(seconds: 1), (timer)
  {
    print(currentTime()) ;
  });
}

main() {
  getUserOrder();
}
String currentTime(){
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  String string = dateFormat.format(DateTime.now());

  return string;
}

