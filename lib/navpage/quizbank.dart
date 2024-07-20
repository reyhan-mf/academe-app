import 'package:acadame/quizpage.dart';
import 'package:flutter/material.dart';

class QuizBank extends StatelessWidget {
  const QuizBank({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuizPage(subjects: 'Matematika', topic: 'Pertambahan', number: '1')
                  ),
                );
              },
              child: const Text('Matematika'),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const QuizPage(subjects: 'Bahasa Indonesia', topic: 'Kata Benda', number: '1'),
                  ),
                );
              },
              child: const Text('Bahasa Indonesia'),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const QuizPage(subjects: 'Bahasa Inggris', topic: 'Kata Kerja', number: '1'),
                  ),
                );
              },
              child: const Text('Bahasa Inggris'),
            ),
          ],
        ),
      ),
    );
  }
}
