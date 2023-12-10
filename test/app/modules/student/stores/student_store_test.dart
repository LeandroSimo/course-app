import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:teste_vrsoft/app/modules/student/repositories/student_repository.dart';
import 'package:teste_vrsoft/app/modules/student/stores/student_store.dart';

class MockStudentStore extends Mock implements StudentStore {}

class MockStudentRepository extends Mock implements StudentRepository {}

void main() {
  late MockStudentStore studentStore;
  late MockStudentRepository studentRepository;

  setUpAll(() {
    studentStore = MockStudentStore();
    studentRepository = MockStudentRepository();
  });
  test('Adding course to student', () async {
    final CourseEntity course = CourseEntity(
      cod: 1,
      name: "Curso",
      description: "Descrição",
      schedule: "Horário",
      level: "Nível",
      hours: "Horas",
    );

    final StudentEntity studentEntity = StudentEntity(
      cod: 1,
      firstName: "Estudante",
      lastName: "Novo",
    );

    // when(() => studentStore.addCourseToStudent(studentEntity, course))
    //     .thenAnswer((_) async => true);

    // expect(studentStore.addCourseToStudent(studentEntity, course),
    // completion(isTrue));
  });
  test('Testing the getCoursesByStudent method', () async {
    final StudentEntity studentEntity = StudentEntity(
      cod: 1,
      firstName: "Estudante",
      lastName: "Novo",
    );

    // when(() => studentStore.getCoursesByStudent(studentEntity))
    //     .thenAnswer((_) async => []);
    // expect(await studentStore.getCoursesByStudent(studentEntity), isA<List>());
  });

  test('Adicionando curso ao aluno com o repository', () {
    final CourseEntity course = CourseEntity(
      cod: 1,
      name: "Curso",
      description: "Descrição",
      schedule: "Horário",
      level: "Nível",
      hours: "Horas",
    );

    final StudentEntity studentEntity = StudentEntity(
      cod: 1,
      firstName: "Estudante",
      lastName: "Novo",
    );

    // when(() => studentRepository.addCourseStudent(studentEntity.cod, course))
    //     .thenAnswer((_) async => true);

    // expect(studentRepository.addCourseStudent(studentEntity.cod, course),
    //     completion(isTrue));
  });
}
