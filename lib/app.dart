import 'package:flutter/material.dart';
import 'package:student_list/canstant.dart';
import 'package:student_list/screens/student_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student List',
      theme: themeData,
      home: StudentListScreen(),
    );
  }
}
