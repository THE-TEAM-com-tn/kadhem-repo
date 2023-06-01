import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:theteam_gyp/core/models/course_model.dart';
import 'package:theteam_gyp/core/models/lesson_model.dart';

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
            child: ListTile(subtitle: _renderLessons(course.lessons)),
          ),
          value: course.title);
    }).toList());
  }
}
