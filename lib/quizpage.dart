import 'package:acadame/data/questions.dart';
import 'package:acadame/models/quiz_question.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.subjects, this.topic, this.number});

  final String subjects;
  final String? topic;
  final String? number;
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<QuizQuestion> questions;
  int _currentQuestionIndex = 0;
  int _timeRemaining = 239;
  late List<int?> _selectedAnswers;
  bool _quizCompleted = false;
  bool _showingSolution = false;

  @override
  void initState() {
    super.initState();
    _initializeQuestions();
  }

  Future<void> _initializeQuestions() async {
    await fetchData(widget.subjects, widget.topic, widget.number);
    setState(() {
      questions = getQuestions(widget.subjects, widget.topic, widget.number);
      _selectedAnswers = List.filled(questions.length, null);
    });
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_timeRemaining > 0 && !_quizCompleted) {
        setState(() {
          _timeRemaining--;
        });
        _startTimer();
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes menit ${remainingSeconds.toString().padLeft(2, '0')} detik';
  }

  void _toggleSolution() {
    setState(() {
      _showingSolution = !_showingSolution;
    });
  }

  void _selectAnswer(int selectedIndex) {
    if (!_quizCompleted) {
      setState(() {
        _selectedAnswers[_currentQuestionIndex] = selectedIndex;
      });
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  bool _allQuestionsAnswered() {
    return _selectedAnswers.every((answer) => answer != null);
  }

  void _finishQuiz() {
    setState(() {
      _quizCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz - ${widget.subjects}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressIndicator(),
            const SizedBox(height: 16),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_showingSolution)
                    Text(
                      'Question ${_currentQuestionIndex + 1}: ${currentQuestion.text}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      softWrap: true,
                    )
                  else
                    Text(
                      currentQuestion.text,
                      style: const TextStyle(fontSize: 18),
                      softWrap: true,
                    ),
                  const SizedBox(height: 24),
                  if (!_showingSolution)
                    ..._buildAnswerOptions(currentQuestion),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            _buildNavigationButtons(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const double indicatorSize = 30;
        const double indicatorSpacing = 8;
        int indicatorCount = questions.length;
        double totalWidth = indicatorCount * (indicatorSize + indicatorSpacing);

        Widget indicatorRow = Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            indicatorCount,
            (index) => Container(
              width: indicatorSize,
              height: indicatorSize,
              margin:
                  const EdgeInsets.symmetric(horizontal: indicatorSpacing / 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getIndicatorColor(index),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: _getIndicatorTextColor(index),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );

        if (totalWidth > constraints.maxWidth) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(width: totalWidth, child: indicatorRow),
          );
        } else {
          return indicatorRow;
        }
      },
    );
  }

  Color _getIndicatorColor(int index) {
    if (_quizCompleted) {
      if (index == _currentQuestionIndex) {
        return Colors.blue;
      } else if (_selectedAnswers[index] != null) {
        bool isCorrect =
            questions[index].shuffledAnswers[_selectedAnswers[index]!] ==
                questions[index].answers[0];
        return isCorrect ? Colors.green : Colors.red;
      }
      return Colors.grey[300]!;
    } else {
      if (index == _currentQuestionIndex) {
        return Colors.blue;
      } else if (_selectedAnswers[index] != null) {
        return Colors.green;
      } else {
        return Colors.grey[300]!;
      }
    }
  }

  Color _getIndicatorTextColor(int index) {
    if (_quizCompleted) {
      if (_selectedAnswers[index] != null) {
        return Colors.white;
      }
      return Colors.black;
    } else {
      if (index == _currentQuestionIndex || _selectedAnswers[index] != null) {
        return Colors.white;
      }
      return Colors.black;
    }
  }

  List<Widget> _buildAnswerOptions(QuizQuestion question) {
    return question.shuffledAnswers.asMap().entries.map<Widget>((entry) {
      int idx = entry.key;
      String answer = entry.value;
      bool isSelected = _selectedAnswers[_currentQuestionIndex] == idx;
      bool isCorrect = answer == question.answers[0];

      Color backgroundColor;
      Color textColor;

      if (_quizCompleted) {
        if (isSelected && isCorrect) {
          backgroundColor = Colors.green;
          textColor = Colors.white;
        } else if (isSelected && !isCorrect) {
          backgroundColor = Colors.red;
          textColor = Colors.white;
        } else if (isCorrect) {
          backgroundColor = Colors.green;
          textColor = Colors.white;
        } else {
          backgroundColor = Colors.white;
          textColor = Colors.black;
        }
      } else {
        backgroundColor = isSelected ? Colors.blue : Colors.white;
        textColor = isSelected ? Colors.white : Colors.black;
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: textColor,
            backgroundColor: backgroundColor,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          onPressed: () => _selectAnswer(idx),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('${String.fromCharCode(65 + idx)}. $answer'),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: _currentQuestionIndex > 0 ? _previousQuestion : null,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey,
          ),
          child: const Text('Previous'),
        ),
        if (_quizCompleted)
          ElevatedButton(
            onPressed: _toggleSolution,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
            ),
            child: Text(_showingSolution ? 'Hide Solution' : 'See Solution'),
          ),
        if (_allQuestionsAnswered() && !_quizCompleted)
          ElevatedButton(
            onPressed: _finishQuiz,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
            ),
            child: const Text('Finish'),
          )
        else
          ElevatedButton(
            onPressed: _currentQuestionIndex < questions.length - 1
                ? _nextQuestion
                : null,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
            child: const Text('Next'),
          ),
      ],
    );
  }
}
