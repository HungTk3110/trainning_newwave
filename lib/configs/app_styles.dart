import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle white = TextStyle(color: Colors.white);

  static const TextStyle black = TextStyle(color: Colors.black);


  static TextStyle white50S18Medium = white.copyWith(
    fontSize: 18,
    color: Colors.white.withOpacity(0.5),
  );

  static TextStyle whiteS8Medium = white.copyWith(
    fontSize: 8,
    color: Colors.white,
  );


  static TextStyle white50S8Medium = white.copyWith(
    fontSize: 8,
    color: Colors.white.withOpacity(0.5),
  );

  static TextStyle whiteS10Medium = white.copyWith(
    fontSize: 10,
    color: Colors.white,
  );

  static TextStyle white75S12Medium = white.copyWith(
    fontSize: 12,
    color: Colors.white.withOpacity(0.75),
  );

  static TextStyle whiteS12Medium = white.copyWith(
    fontSize: 12,
    color: Colors.white,
  );

  static TextStyle whiteS12bold = white.copyWith(
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle blackS12bold = white.copyWith(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );



  static TextStyle whiteS18Medium = white.copyWith(
    fontSize: 18,
    color: Colors.white,
  );
  

  static TextStyle whiteS18Bold = white.copyWith(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle white50S18Bold = white.copyWith(
    fontSize: 18,
    color: Colors.white.withOpacity(0.5),
    fontWeight: FontWeight.bold,
  );

  static TextStyle whiteS64Bold = white.copyWith(
    fontSize: 64,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

}
