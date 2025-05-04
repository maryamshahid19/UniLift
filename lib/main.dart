import 'package:flutter/material.dart';
import 'package:unilift/screens/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniLift',
      home: const Dashboard(),
    );
  }
}
