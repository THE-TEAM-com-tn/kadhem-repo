import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

// #####
const htmlData1 = """
<body style="font-family: Arial, sans-serif; margin: 0; padding: 20px;">
  <h1 style="color: #333; font-size: 24px; margin-bottom: 20px;">Business Lesson</h1>

  <section>
    <h2 style="color: #555; font-size: 20px; margin-bottom: 10px;">Introduction</h2>
    <p style="margin-bottom: 20px;">This is an introduction to the business lesson. It provides an overview of the topic and sets the context for the lesson.</p>
    <img src="https://firebasestorage.googleapis.com/v0/b/fir-cruddemo-2bf79.appspot.com/o/TestFolder%2Fac90d887-6fe4-423e-b889-8f90a612ebf5?alt=media&token=4e812fc6-c65c-4385-9abf-fddd2207a9bc" alt="Image 1" style="max-width: 100%; height: auto; margin-bottom: 20px;">
  </section>

  <section>
    <h2 style="color: #555; font-size: 20px; margin-bottom: 10px;">Main Content</h2>
    <p style="margin-bottom: 20px;">Here is the main content of the business lesson. It covers the key concepts, strategies, and examples related to the topic.</p>
    <img src="https://firebasestorage.googleapis.com/v0/b/fir-cruddemo-2bf79.appspot.com/o/TestFolder%2Fac90d887-6fe4-423e-b889-8f90a612ebf5?alt=media&token=4e812fc6-c65c-4385-9abf-fddd2207a9bc" alt="Image 2" style="max-width: 100%; height: auto; margin-bottom: 20px;">
    <img src="https://firebasestorage.googleapis.com/v0/b/fir-cruddemo-2bf79.appspot.com/o/TestFolder%2Fac90d887-6fe4-423e-b889-8f90a612ebf5?alt=media&token=4e812fc6-c65c-4385-9abf-fddd2207a9bc" alt="Image 3" style="max-width: 100%; height: auto; margin-bottom: 20px;">
  </section>

  <section>
    <h2 style="color: #555; font-size: 20px; margin-bottom: 10px;">Conclusion</h2>
    <p style="margin-bottom: 20px;">In conclusion, this business lesson provides a summary of the key points discussed and highlights the key takeaways for the learners.</p>
    <img src="https://firebasestorage.googleapis.com/v0/b/fir-cruddemo-2bf79.appspot.com/o/TestFolder%2Fac90d887-6fe4-423e-b889-8f90a612ebf5?alt=media&token=4e812fc6-c65c-4385-9abf-fddd2207a9bc" alt="Image 4" style="max-width: 100%; height: auto; margin-bottom: 20px;">
  </section>

  <section>
    <h2 style="color: #555; font-size: 20px; margin-bottom: 10px;">Introduction</h2>
    <p style="margin-bottom: 20px;">This is an introduction to the business lesson. It provides an overview of the topic and sets the context for the lesson.</p>

  </section>
</body>
""";

const htmlData2 = """
<style>
    body {
      font-family: Arial, sans-serif;
      padding: 20px;
    }
    h1 {
      color: #333;
      font-size: 24px;
      margin-bottom: 20px;
    }
    .question {
      margin-bottom: 20px;
    }
    .options {
      margin-bottom: 10px;
    }
    .result {
      color: green;
      font-weight: bold;
    }
    .score {
      margin-top: 20px;
    }
  </style>
</head>
<body>
  <h1>Quiz Game</h1>

  <div class="question">
    <p>Question 1: What is the capital of France?</p>
    <div class="options">
      <label><input type="radio" name="q1" value="a"> Paris</label><br>
      <label><input type="radio" name="q1" value="b"> London</label><br>
      <label><input type="radio" name="q1" value="c"> Rome</label><br>
      <label><input type="radio" name="q1" value="d"> Berlin</label>
    </div>
  </div>

  <div class="question">
    <p>Question 2: What is the largest planet in our solar system?</p>
    <div class="options">
      <label><input type="radio" name="q2" value="a"> Jupiter</label><br>
      <label><input type="radio" name="q2" value="b"> Saturn</label><br>
      <label><input type="radio" name="q2" value="c"> Earth</label><br>
      <label><input type="radio" name="q2" value="d"> Mars</label>
    </div>
  </div>

  <button onclick="checkAnswers()">Submit</button>

  <div class="score">
    <h2>Score: <span id="score">0</span>/2</h2>
  </div>

  <script>
    function checkAnswers() {
      var score = 0;
      
      // Check answers for Question 1
      var q1Options = document.getElementsByName('q1');
      for (var i = 0; i < q1Options.length; i++) {
        if (q1Options[i].checked && q1Options[i].value === 'a') {
          score++;
        }
      }

      // Check answers for Question 2
      var q2Options = document.getElementsByName('q2');
      for (var j = 0; j < q2Options.length; j++) {
        if (q2Options[j].checked && q2Options[j].value === 'a') {
          score++;
        }
      }

      // Display the score
      var scoreElement = document.getElementById('score');
      scoreElement.innerText = score;

      // Display the result
      var resultElement = document.createElement('p');
      if (score === 2) {
        resultElement.className = 'result';
        resultElement.innerText = 'Congratulations! You answered all questions correctly!';
      } else {
        resultElement.innerText = 'You missed some questions. Try again!';
      }
      document.body.appendChild(resultElement);
    }
  </script>
""";
// #####

class LessonModel {
  final String? id;
  final String title;
  final String content;

  const LessonModel(this.id, this.title, this.content);
}

class CourseModel {
  CourseModel(this.title, this.description,
      [this.lessons = const <LessonModel>[]]);

  final String title;
  final String description;
  final List<LessonModel> lessons;
}

List<LessonModel> lessons = [
  LessonModel(
      "LessonModel 1+5",
      "Install Flutter development tools according to the official documentation.\n",
      "zae"),
  LessonModel(
      "LessonModel 1+5",
      "Install Flutter development tools according to the official documentation.\n",
      "zae"),
  LessonModel(
      "LessonModel 1+5",
      "Install Flutter development tools according to the official documentation.\n",
      "zae")
];

List<CourseModel> getCourses() {
  return [
    CourseModel(
        'CourseModel 1: Install Flutter',
        'Install Flutter development tools according to the official documentation.\nInstall Flutter development tools according to the official documentation.\nInstall Flutter development tools according to the official documentation.\n',
        lessons),
    CourseModel('CourseModel 1: Create a project',
        'Open your terminal, run `flutter create <project_name>` to create a new project.\nOpen your terminal, run `flutter create <project_name>` to create a new project.\nOpen your terminal, run `flutter create <project_name>` to create a new project.\n'),
    CourseModel('CourseModel 2: Run the app',
        'Change your terminal directory to the project directory, enter `flutter run`.\nChange your terminal directory to the project directory, enter `flutter run`.\nChange your terminal directory to the project directory, enter `flutter run`.\n'),
  ];
}

class Course extends StatefulWidget {
  const Course({Key? key}) : super(key: key);
  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  final List<CourseModel> _courses = getCourses();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildCourse(_courses[0]),
      ),
    );
  }

  Widget _buildLesson(String lesson) {
    return SingleChildScrollView(
      child: Html(
        data: lesson,
      ),
    );
  }

  Widget _renderLesson(lesson) {
    return ExpansionPanelList.radio(
      children: [
        ExpansionPanelRadio(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(lesson.title),
              );
            },
            body: _buildLesson(htmlData1),
            value: lesson.title)
      ],
    );
  }

  Widget _buildCourse(CourseModel course) {
    return ExpansionPanelList.radio(children: [
      ExpansionPanelRadio(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(course.title),
            );
          },
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(subtitle: _renderLesson(course)),
          ),
          value: course.title)
    ]);
  }
}
