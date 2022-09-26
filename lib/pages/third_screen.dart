import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  static const path = 'third';
  static const name = 'Third';
  static const location = path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Scaffold(
        body: Center(
          child: Text('third'),
        ),
      ),
    );
  }
}
