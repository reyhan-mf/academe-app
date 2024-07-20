import 'package:flutter/material.dart';

class SolutionPage extends StatefulWidget {
  const SolutionPage({super.key, required this.questionIndex});

  final int questionIndex;

  @override
  State<SolutionPage> createState() => _SolutionPageState();
}

class _SolutionPageState extends State<SolutionPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}