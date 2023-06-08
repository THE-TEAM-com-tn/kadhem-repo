import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:theteam_gyp/core/models/course_model.dart';
import 'package:theteam_gyp/core/models/lesson_model.dart';
import 'package:theteam_gyp/user-interface/quiz/controller/index_controller.dart';
import 'package:theteam_gyp/user-interface/quiz/view/screens/home_screen.dart';

class Course extends StatefulWidget {
  const Course({Key? key, required this.courses}) : super(key: key);

  final List<CourseModel> courses;

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        child: Container(
          child: _buildCourse(widget.courses),
        ),
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

  // Widget _renderQuizzes() {

  // }

  Widget _renderLessons(List<LessonModel> lessons) {
    return ExpansionPanelList.radio(
        children: lessons.map<ExpansionPanelRadio>((LessonModel lesson) {
      return ExpansionPanelRadio(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(lesson.title),
            );
          },
          body: ListTile(subtitle: _buildLesson(lesson.content)),
          value: lesson.title);
    }).toList());
  }

  Widget _renderQuizzes() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
      child: Container(
        color: Color.fromARGB(255, 89, 203, 93),
        child: ListTile(
          hoverColor: Color.fromARGB(255, 23, 118, 26),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => ChangeNotifierProvider<IndexController>(
                    create: (context) => IndexController(),
                    child: FirstPage()));
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: Text(
            "Quiz 1",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 84, 84, 84),
            ),
          ),
          title: Text(
            "Take Quiz",
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: -0.3,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCourse(List<CourseModel> courses) {
    return ExpansionPanelList.radio(
        children: courses.map<ExpansionPanelRadio>((CourseModel course) {
      return ExpansionPanelRadio(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(course.title),
            );
          },
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(subtitle: _renderLessons(course.lessons)),
                ListTile(
                  subtitle: _renderQuizzes(),
                )
              ],
            ),
          ),
          value: course.title);
    }).toList());
  }
}
