import 'package:flutter/material.dart';
import 'question.dart';

@immutable
class QuizCategory {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;
  final String difficulty;
  final List<Question> questions;

  const QuizCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
    required this.difficulty,
    required this.questions,
  });

  int get questionCount => questions.length;
}
