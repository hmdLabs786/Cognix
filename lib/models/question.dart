import 'package:flutter/foundation.dart';

@immutable
class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  const Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  }) : assert(
          correctAnswerIndex >= 0 && correctAnswerIndex < 4,
          'correctAnswerIndex must be between 0 and 3.',
        );

  /// Returns the string value of the correct answer
  String get correctAnswer => options[correctAnswerIndex];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Question &&
          runtimeType == other.runtimeType &&
          questionText == other.questionText &&
          listEquals(options, other.options) &&
          correctAnswerIndex == other.correctAnswerIndex;

  @override
  int get hashCode =>
      questionText.hashCode ^ options.hashCode ^ correctAnswerIndex.hashCode;
}
