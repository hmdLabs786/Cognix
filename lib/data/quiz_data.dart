import 'package:flutter/material.dart';
import '../models/question.dart';
import '../models/quiz_category.dart';

class QuizData {
  QuizData._();

  static const List<Question> generalKnowledgeQuestions = [
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

  static const List<Question> scienceAndCosmosQuestions = [
    Question(
      questionText: 'What is the speed of light in vacuum approximately?',
      options: ['150,000 km/s', '300,000 km/s', '500,000 km/s', '1,000,000 km/s'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'What particle has a negative electric charge?',
      options: ['Proton', 'Neutron', 'Electron', 'Positron'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'Which galaxy is closest to our Milky Way?',
      options: ['Andromeda', 'Triangulum', 'Sombrero', 'Whirlpool'],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText: 'What is the main gas that makes up the Earth’s atmosphere?',
      options: ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Argon'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'What is the theoretical boundary around a black hole called?',
      options: ['Event Horizon', 'Singularity', 'Photon Sphere', 'Accretion Disk'],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText: 'Which element has the lowest boiling point of all elements?',
      options: ['Hydrogen', 'Helium', 'Nitrogen', 'Neon'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'How long does sunlight take to reach Earth approximately?',
      options: ['4 minutes', '8 minutes', '12 minutes', '16 minutes'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'What is the powerhouse organelle of the eukaryotic cell?',
      options: ['Ribosome', 'Nucleus', 'Mitochondria', 'Golgi apparatus'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'Which scientist formulated the Three Laws of Motion?',
      options: ['Albert Einstein', 'Isaac Newton', 'Galileo Galilei', 'Niels Bohr'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'What is the hottest planet in our solar system?',
      options: ['Mercury', 'Venus', 'Mars', 'Jupiter'],
      correctAnswerIndex: 1,
    ),
  ];

  static const List<Question> techAndFlutterQuestions = [
    Question(
      questionText: 'Which programming language is Flutter written in and powered by?',
      options: ['Kotlin', 'Swift', 'Dart', 'JavaScript'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'What rendering engine was originally used by Flutter prior to Impeller?',
      options: ['Skia', 'Blink', 'Gecko', 'MetalKit'],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText: 'Which company created and actively open-sources Flutter?',
      options: ['Meta', 'Apple', 'Google', 'Microsoft'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'What widget in Flutter handles asynchronous snapshots from a Future?',
      options: ['StreamBuilder', 'FutureBuilder', 'ValueListenableBuilder', 'AnimatedBuilder'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'What keyword defines a compile-time immutable value in Dart?',
      options: ['final', 'var', 'const', 'static'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'Which architectural concept powers Flutter’s UI updates?',
      options: ['Declarative UI', 'Imperative UI', 'Component Object Model', 'Data Binding XML'],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText: 'What file in a Flutter app manages dependencies and assets?',
      options: ['package.json', 'pubspec.yaml', 'build.gradle', 'manifest.json'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'What is the root widget tree building method in StatelessWidget?',
      options: ['render()', 'create()', 'build()', 'paint()'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'Which tree in Flutter handles geometry, sizing, and painting?',
      options: ['Widget Tree', 'Element Tree', 'RenderObject Tree', 'State Tree'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'What command executes automated unit & widget tests in Flutter?',
      options: ['flutter test', 'flutter run --test', 'flutter analyze', 'dart run test'],
      correctAnswerIndex: 0,
    ),
  ];

  static const List<QuizCategory> categories = [
    QuizCategory(
      id: 'general_knowledge',
      title: 'General Knowledge',
      description: 'Test your world trivia, history, and geography.',
      icon: Icons.public_rounded,
      accentColor: Color(0xFF818CF8), // Electric Violet
      difficulty: 'Beginner',
      questions: generalKnowledgeQuestions,
    ),
    QuizCategory(
      id: 'science_cosmos',
      title: 'Science & Cosmos',
      description: 'Journey across physics, astronomy, and nature.',
      icon: Icons.rocket_launch_rounded,
      accentColor: Color(0xFF38BDF8), // Sky Blue
      difficulty: 'Intermediate',
      questions: scienceAndCosmosQuestions,
    ),
    QuizCategory(
      id: 'tech_flutter',
      title: 'Tech & Flutter',
      description: 'Challenge your mobile dev & software engineering skills.',
      icon: Icons.terminal_rounded,
      accentColor: Color(0xFF34D399), // Emerald
      difficulty: 'Advanced',
      questions: techAndFlutterQuestions,
    ),
  ];
}
