import 'package:flutter/material.dart';

class QuizBank extends StatelessWidget {
  const QuizBank({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Bank'),
      ),
      body: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Quiz Bank Page '),
            Text('Quiz Bank Page'),
          ],
        ),
      ),
    );
  }
}
