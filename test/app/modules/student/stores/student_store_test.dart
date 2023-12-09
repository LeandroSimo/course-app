import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:teste_vrsoft/app/modules/student/stores/student_store.dart';

class MockStudentStore extends Mock implements StudentStore {}

void main() {
  late MockStudentStore studentStore;

  setUpAll(() {
    studentStore = MockStudentStore();
  });
  test('Adding course to student', () async {
    final StudentEntity studentEntity = StudentEntity(
      cod: 1,
      firstName: "Estudante",
      lastName: "Novo",
    );
    final CourseEntity course = CourseEntity(
      cod: 1,
      name: "Curso",
      description: "Descrição",
      schedule: "Horário",
      level: "Nível",
      hours: "Horas",
    );

    when(() => studentStore.addCourseToStudent(course,
        studentEntity: studentEntity)).thenAnswer((_) async => true);
  });
  test('Testing the getAllCourse method', () async {
    final StudentEntity studentEntity = StudentEntity(
      cod: 1,
      firstName: "Estudante",
      lastName: "Novo",
    );

    when(() => studentStore.getCoursesByStudent(studentEntity))
        .thenAnswer((_) async => []);
    expect(await studentStore.getCoursesByStudent(studentEntity), isA<List>());
  });
}
