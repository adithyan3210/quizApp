import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int totalScore = 0;

  List<Question> questions = [
    Question(
      questionText: "1+1?",
      options: ["2", "6", "8", "3"],
      correctOption: "2",
    ),
    Question(
      questionText: "10+15?",
      options: ["21", "23", "25", "30"],
      correctOption: "25",
    ),
    Question(
      questionText: "50+15?",
      options: ["60", "70", "71", "65"],
      correctOption: "65",
    ),
    Question(
      questionText: "100+200?",
      options: ["310", "203", "300", "250"],
      correctOption: "300",
    ),
    Question(
      questionText: "1000-350?",
      options: ["650", "750", "655", "800"],
      correctOption: "650",
    ),
    Question(
      questionText: "100/5?",
      options: ["30", "20", "18", "65"],
      correctOption: "20",
    ),
    Question(
      questionText: "15*15?",
      options: ["155", "150", "225", "250"],
      correctOption: "225",
    ),
    Question(
      questionText: "105*2?",
      options: ["210", "215", "200", "211"],
      correctOption: "211",
    ),
    Question(
      questionText: "50+100+5?",
      options: ["155", "200", "158", "165"],
      correctOption: "155",
    ),
    Question(
      questionText: "558/6?",
      options: ["69", "96", "93", "39"],
      correctOption: "93",
    ),
  ];

  void _checkAnswer(String selectedOption) {
    String correctOption = questions[currentQuestionIndex].correctOption;
    if (selectedOption == correctOption) {
      setState(() {
        totalScore++;
      });
    }
    _showNextQuestion();
  }

  void _showNextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Quiz Result"),
          content:
              Text("Score: $totalScore out of ${questions.length}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetQuiz();
              },
              child: const Text("Finish Quiz",style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }

  void _resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true,backgroundColor:const Color.fromARGB(255, 114, 228, 118),
          title: const Text('Qizo Quiz app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             
              const SizedBox(height: 16),
              Center(
                child: Text(
                  questions[currentQuestionIndex].questionText,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(height: 20),
              ...questions[currentQuestionIndex].options.map((option) {
                return ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 114, 228, 118)),
                  onPressed: () {
                    _checkAnswer(option);
                  },
                  child: Text(option),
                );
              }).toList(),
              const SizedBox(height: 60,),
               Center(
                 child: Text(
                  "Question ${currentQuestionIndex + 1}/${questions.length}",
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                             ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final String correctOption;

  Question({
    required this.questionText,
    required this.options,
    required this.correctOption,
  });
}
