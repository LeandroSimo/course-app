import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/course_student/courseStudent_store.dart';
import 'package:flutter/material.dart';

class CourseStudentPage extends StatefulWidget {
  final String title;
  const CourseStudentPage({Key? key, this.title = 'CourseStudentPage'}) : super(key: key);
  @override
  CourseStudentPageState createState() => CourseStudentPageState();
}
class CourseStudentPageState extends State<CourseStudentPage> {
  final CourseStudentStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}