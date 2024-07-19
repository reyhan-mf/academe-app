import 'package:acadame/bottom_nav.dart';
import 'package:acadame/navpage/home.dart';
import 'package:acadame/navpage/quizbank.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomNav(),
    );
  }
}

