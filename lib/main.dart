import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() {
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initObjectBox();
//   runApp(
//     ModularApp(
//       module: AppModule(),
//       child: AppWidget(),
//     ),
//   );
// }

// Future<void> initObjectBox() async {
//   Store _store = await CourseStudentObjectBox().getStore();

//   final studentEntity = StudentEntity(
//     firstName: 'Leandro',
//     lastName: 'Simoes',
//   );

//   final course1 = CourseEntity(
//     name: 'Programming 101',
//     description: 'Introduction to Programming',
//     schedule: 'Mon-Wed-Fri 10:00 AM',
//     level: 'Beginner',
//     hours: '30',
//   );
//   final course2 = CourseEntity(
//     name: 'Java Essentials',
//     description: 'Java Programming',
//     schedule: 'Mon-Wed-Fri 10:00 AM',
//     level: 'Beginner',
//     hours: '30',
//   );

//   // // Adiciona o curso ao aluno
//   studentEntity.addCourseToStudent(course2);

//   // final courseStudentEntity = CourseStudentEntity(
//   //   student: ToOne<StudentEntity>()..target = studentEntity,
//   //   course: ToOne<CourseEntity>()..target = courseEntity,
//   // );

//   _store.box<StudentEntity>().put(studentEntity);
//   _store.box<CourseEntity>().put(course1);
//   _store.box<CourseEntity>().put(course2);
//   // _store.box<CourseStudentEntity>().put(courseStudentEntity);
// }
