import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:objectbox/objectbox.dart';
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
    firstName: 'Leandro',
    lastName: 'Simoes',
  );

  final courseEntity = CourseEntity(
    name: 'Programming 101',
    description: 'Introduction to Programming',
    schedule: 'Mon-Wed-Fri 10:00 AM',
    level: 'Beginner',
    hours: '30',
  );

  // // Adiciona o curso ao aluno
  // bool added = studentEntity.addCourseToStudent(courseEntity);

  // final courseStudentEntity = CourseStudentEntity(
  //   student: ToOne<StudentEntity>()..target = studentEntity,
  //   course: ToOne<CourseEntity>()..target = courseEntity,
  // );

  _store.box<StudentEntity>().put(studentEntity);
  _store.box<CourseEntity>().put(courseEntity);
  // _store.box<CourseStudentEntity>().put(courseStudentEntity);
}
