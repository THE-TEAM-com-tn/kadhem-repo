import 'package:theteam_gyp/core/models/lesson_model.dart';

class CourseModel {
  CourseModel(
      {this.id,
      required this.title,
      required this.description,
      required this.lessons});

  String? id;
  String title;
  String description;
  List<LessonModel> lessons;
}
