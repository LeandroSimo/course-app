import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:teste_vrsoft/app/database/objectbox.g.dart';
import 'package:teste_vrsoft/app/database/student_objectbox.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class MockTest extends Mock {
  late CourseStudentObjectBox _studentObjectBox;

  MockTest() {
    _studentObjectBox = CourseStudentObjectBox();
  }

  Future<Box> getStudent() async {
    final store = await _studentObjectBox.getStore();
    return store.box<StudentEntity>();
  }

  Future<dynamic> createStudent(StudentEntity student, Function() func) async {
    final store = await getStudent();

    final query =
        store.query(StudentEntity_.firstName.equals(student.firstName)).build();
    final existingStudents = query.find() as List<StudentEntity>;

    if (existingStudents.isNotEmpty) {
      query.close();
      return func;
    }
    query.close();
    return store.put(student);
  }

  Future<List<StudentEntity>> readStudent() async {
    final store = await getStudent();
    return store.getAll() as List<StudentEntity>;
  }

  Future<void> updateStudent(StudentEntity student) async {
    final store = await getStudent();
    store.put(student);
  }

  Future<void> clearStudents() async {
    final store = await getStudent();
    store.removeAll();
  }

  Future<void> deleteStudent(StudentEntity student) async {
    final store = await getStudent();
    store.remove(student.cod);
  }

  Future<int> addAllCoursesToStudent(
      StudentEntity student, List<CourseEntity> courses) async {
    final store = await getStudent();

    bool isExceeded = student.courses.length > 3;

    if (!isExceeded) {
      student.courses.addAll(courses);
    }
    return store.put(student);
  }
}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel('plugins.flutter.io/path_provider')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    return 'test/app/modules';
  });

  await getApplicationDocumentsDirectory();

  group('StudentRepository', () {
    late MockTest mockTest;

    setUp(() {
      mockTest = MockTest();
    });

    test('Create student successfully', () async {
      await mockTest.clearStudents();
      final student = StudentEntity(firstName: 'Teste', lastName: "");
      await mockTest.createStudent(student, () {});

      final studentsList = await mockTest.readStudent();
      expect(studentsList.length, 1);
      expect(studentsList.first.firstName, 'Teste');
    });

    test('Creating a student with an existing name should return a function',
        () async {
      final existingStudent = StudentEntity(firstName: 'Teste', lastName: '');
      await mockTest.createStudent(existingStudent, () {});

      final duplicateStudent = StudentEntity(firstName: 'Teste', lastName: '');
      final callback = await mockTest.createStudent(
          duplicateStudent, () => debugPrint("Usuário já existe"));

      expect(callback, isA<Function>());
    });

    test("Adding Courses to student", () async {
      final List<CourseEntity> courses = [
        CourseEntity(
          cod: 1,
          name: "Curso",
          description: "Descrição",
          schedule: "Horário",
          level: "Nível",
          hours: "Horas",
        ),
        CourseEntity(
          cod: 2,
          name: "Curso",
          description: "Descrição",
          schedule: "Horário",
          level: "Nível",
          hours: "Horas",
        ),
      ];

      final StudentEntity studentEntity = StudentEntity(
        cod: 1,
        firstName: "Estudante",
        lastName: "Novo",
      );

      // when(() => studentStore.addAllCourseToStudent(studentEntity, courses))
      //     .thenAnswer((_) async => 3);

      // expect(studentRepository.addAllCoursesToStudent(studentEntity, courses),
      //     isA<Future<int>>());

      final result =
          await mockTest.addAllCoursesToStudent(studentEntity, courses);

      expect(result, isA<int>());
    });
  });
}
