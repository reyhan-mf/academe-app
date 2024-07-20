import 'package:acadame/models/quiz_question.dart';

List<QuizQuestion> getQuestions(String subjects, String topic, String number) {
  return [
    QuizQuestion(
      'What are the building blocks of $subjects dan $topic dan $number?',
      [
        'Widgets',
        'Components',
        'Blocks',
        'Functions',
      ],
    ),
    QuizQuestion(
      'How are $subjects UIs built?',
      [
        'By combining widgets in code',
        'By combining widgets in a visual editor',
        'By defining widgets in config files',
        'By using XCode for iOS and Android Studio for Android',
      ],
    ),
    // Add more questions here...
  ];
}
