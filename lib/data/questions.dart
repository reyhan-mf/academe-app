import 'package:acadame/models/quiz_question.dart';


import 'package:google_generative_ai/google_generative_ai.dart';

String apiKey = "AIzaSyBp83nEOiJNSGvvvjbwy2DWslc3pYMUhBI"; // gemini 1.5
List<QuizQuestion> questions = [];

Future<void> fetchData(String subjects, String? topic, String? number) async {
  final model = GenerativeModel(
      model: 'gemini-1.5-flash', apiKey: apiKey);
  final content = [
    Content.text(
        '''
Buatkan $number soal $subjects dengan EMPAT pilihan jawaban. 
Ikuti format berikut dengan ketat untuk setiap soal:

1. [Tulis pertanyaan lengkap di sini tanpa nomor atau label]
[Jawaban benar]
[Jawaban salah 1]
[Jawaban salah 2]
[Jawaban salah 3]

2. [Pertanyaan berikutnya]
[Jawaban benar]
[Jawaban salah 1]
[Jawaban salah 2]
[Jawaban salah 3]

(Lanjutkan hingga 5 soal)

PENTING:
- Jangan gunakan label seperti "Soal 1" atau "a)", "b)", "c)", "d)" untuk jawaban.
- Pastikan setiap soal memiliki tepat satu pertanyaan dan empat pilihan jawaban.
- Jawaban yang benar harus selalu berada di baris pertama setelah pertanyaan.
''')
  ];
  final response = await model.generateContent(content);
  String? text = response.text;
  print(text);
  print(text);
  if (text != null) {
    List<QuizQuestion> generatedQuestions = [];
    List<String> questionBlocks = text.split('\n\n');
    for (String block in questionBlocks) {
      List<String> lines = block.split('\n');
      if (lines.length >= 5) {
        String questionText = lines[0].trim();
        List<String> answers =
            lines.sublist(1, 5).map((answer) => answer.trim()).toList();
        generatedQuestions.add(QuizQuestion(questionText, answers));
      }
    }

    // Simpan list questions dengan hasil yang sudah di-generate
    questions = generatedQuestions;

    // Cetak questions termasuk prompt
    print('Prompt: ${content[0].parts[0]}');
    print('');
    questions.forEach((question) {
      print('Pertanyaan: ${question.questionText}');
      print('Jawaban:');
      for (int i = 0; i < question.answers.length; i++) {
        print(' - ${question.answers[i]}');
      }
      print('');
    });
  } else {
    print('Gagal memuat data');
  }
}


List<QuizQuestion> getQuestions(String subjects, String? topic, String? number) {
  return questions;  // Return the global questions list
}

// List<QuizQuestion> getQuestions(String subjects, String? topic, String? number) {
//   return [
//     QuizQuestion(
//       'What are the building blocks of $subjects dan $topic dan $number?',
//       [
//         'Widgets',
//         'Components',
//         'Blocks',
//         'Functions',
//       ],
//     ),
//     QuizQuestion(
//       'How are $subjects UIs built?',
//       [
//         'By combining widgets in code',
//         'By combining widgets in a visual editor',
//         'By defining widgets in config files',
//         'By using XCode for iOS and Android Studio for Android',
//       ],
//     ),
//     // Add more questions here...
//   ];
// }
