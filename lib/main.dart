
import 'package:flutter/material.dart';
import 'package:sqlflite_student_managment/home.dart';

void main(){
  runApp(SqlfliteApp());
}

class SqlfliteApp extends StatelessWidget {
  const SqlfliteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}