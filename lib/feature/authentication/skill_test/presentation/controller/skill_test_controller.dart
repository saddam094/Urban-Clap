import 'package:get/get.dart';

class SkillTestController extends GetxController {
  var currentQuestionIndex = 0.obs;
  RxBool isSelectedOption = false.obs;

  final questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Berlin', 'Madrid', 'Paris', 'Rome'],
      'answer': 'Paris'
    },
    {
      'question': 'Flutter is developed by?',
      'options': ['Apple', 'Facebook', 'Microsoft', 'Google'],
      'answer': 'Google'
    },
    {
      'question': 'Which widget is used for layout in Flutter?',
      'options': ['Column', 'Button', 'Text', 'Image'],
      'answer': 'Column'
    },
    {
      'question': 'What language is used to write Flutter apps?',
      'options': ['Kotlin', 'Swift', 'Dart', 'Java'],
      'answer': 'Dart'
    },
    {
      'question': 'Which keyword is used to declare a constant in Dart?',
      'options': ['let', 'const', 'define', 'final'],
      'answer': 'const'
    },
    {
      'question': 'Which method is used to update UI in StatefulWidget?',
      'options': ['build()', 'update()', 'setState()', 'refresh()'],
      'answer': 'setState()'
    },
    {
      'question': 'Which widget is used to scroll a list vertically?',
      'options': ['ListView', 'Column', 'GridView', 'PageView'],
      'answer': 'ListView'
    },
    {
      'question': 'How many root widgets can a Flutter app have?',
      'options': ['One', 'Two', 'Unlimited', 'None'],
      'answer': 'One'
    },
    {
      'question': 'What does hot reload do in Flutter?',
      'options': [
        'Rebuilds entire app from scratch',
        'Restarts the app',
        'Updates code changes without restarting the app',
        'Closes the app'
      ],
      'answer': 'Updates code changes without restarting the app'
    },
    {
      'question': 'Which state management is provided by GetX?',
      'options': ['Bloc', 'Provider', 'MobX', 'Reactive + Simple'],
      'answer': 'Reactive + Simple'
    },
  ].obs;

  var selectedAnswers = <int, String>{}.obs;

  void selectAnswer(int index, String option) {
    selectedAnswers[index] = option;
    isSelectedOption.value = true;
  }

  bool isSelected(int questionIndex, String option) {
    return selectedAnswers[questionIndex] == option;
  }

  bool isCorrect(int questionIndex, String option) {
    return questions[questionIndex]['answer'] == option;
  }

  int calculateScore() {
    int score = 0;
    selectedAnswers.forEach((index, answer) {
      if (questions[index]['answer'] == answer) {
        score++;
      }
    });
    return score;
  }

}