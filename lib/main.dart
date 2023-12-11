import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/database/objectbox.g.dart';
import 'package:teste_vrsoft/app/database/student_objectbox.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initObjectBox();
  runApp(
    ModularApp(
      module: AppModule(),
      child: AppWidget(),
    ),
  );
}

Future<void> initObjectBox() async {
  Store _store = await CourseStudentObjectBox().getStore();

  final studentEntity = StudentEntity(
    firstName: 'VRSoft',
    lastName: 'Software',
  );

  final course1 = CourseEntity(
    name: 'Dart Basics',
    description: 'Introduction to Programming with Dart',
    schedule: 'Mon-Wed-Fri 10:00 AM',
    level: 'Beginner',
    hours: '30',
  );
  final course2 = CourseEntity(
    name: 'Java Essentials',
    description: 'Java Programming',
    schedule: 'Mon-Wed-Fri 10:00 AM',
    level: 'Beginner',
    hours: '30',
  );

  // final courseStudentEntity = CourseStudentEntity(
  //   student: ToOne<StudentEntity>()..target = studentEntity,
  //   course: ToOne<CourseEntity>()..target = courseEntity,
  // );

  _store.box<StudentEntity>().put(studentEntity);
  _store.box<CourseEntity>().put(course1);
  _store.box<CourseEntity>().put(course2);
  // _store.box<CourseStudentEntity>().put(courseStudentEntity);
}
