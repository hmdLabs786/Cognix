import '../models/question.dart';

class QuizData {
  QuizData._();

  static const List<Question> questions = [
    Question(
      questionText: 'What is the capital city of Australia?',
      options: ['Sydney', 'Melbourne', 'Canberra', 'Brisbane'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'Which planet is known as the "Red Planet"?',
      options: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'What is the chemical symbol for Gold?',
      options: ['Au', 'Ag', 'Fe', 'Gd'],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText: 'Which ocean is the largest on Earth?',
      options: [
        'Atlantic Ocean',
        'Indian Ocean',
        'Arctic Ocean',
        'Pacific Ocean',
      ],
      correctAnswerIndex: 3,
    ),
    Question(
      questionText: 'Who painted the famous artwork "Starry Night"?',
      options: [
        'Pablo Picasso',
        'Vincent van Gogh',
        'Claude Monet',
        'Leonardo da Vinci',
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'What is the fastest land animal in the world?',
      options: ['Pronghorn', 'Cheetah', 'Lion', 'Falcon'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'How many bones are in the adult human body?',
      options: ['186', '206', '216', '226'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'Which country invented paper in ancient times?',
      options: ['Egypt', 'Greece', 'China', 'Rome'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'What is the hardest natural substance known on Earth?',
      options: ['Diamond', 'Graphene', 'Quartz', 'Titanium'],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText: 'In which year did the Apollo 11 mission land humans on the Moon?',
      options: ['1965', '1969', '1971', '1975'],
      correctAnswerIndex: 1,
    ),
  ];

  // Backward compatibility alias
  static const List<Question> generalKnowledgeQuestions = questions;
}
