import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:teste_vrsoft/app/database/repositories/course_student_repository.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';

class MockCourseStudentRepository extends Mock
    implements CourseStudentRepository {}

void main() {
  late MockCourseStudentRepository repository;
  setUp(() {
    repository = MockCourseStudentRepository();
  });

  group('CourseStudentRepository tests', () {
    test('It should return a list of CourseStudentEntity', () async {
      when(() => repository.getAllCourseStudents()).thenAnswer(
        (_) async => [],
      );
      final result = await repository.getAllCourseStudents();
      expect(result, isA<List>());
    });

    test('Must add a student to the intersection table', () async {
      final student = StudentEntity(
        firstName: 'Teste',
        lastName: 'Teste',
        cod: 0,
      );

      final CourseEntity course = CourseEntity(
        name: 'Teste',
        description: 'Teste',
        schedule: 'Teste',
        level: 'Teste',
        hours: 'Teste',
        cod: 0,
      );

      when(() => repository.createCourseStudent(student, course)).thenAnswer(
        (_) async => 1,
      );
      final result = await repository.createCourseStudent(student, course);
      expect(result, 1);
    });
  });
}
