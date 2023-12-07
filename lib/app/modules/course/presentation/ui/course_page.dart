import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter/material.dart';
import 'package:teste_vrsoft/app/modules/course/stores/course_store.dart';

class CoursePage extends StatefulWidget {
  final String title;
  const CoursePage({Key? key, this.title = 'CoursePage'}) : super(key: key);
  @override
  CoursePageState createState() => CoursePageState();
}

class CoursePageState extends State<CoursePage> {
  final CourseStore store = Modular.get();

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
