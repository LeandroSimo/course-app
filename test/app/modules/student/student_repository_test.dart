import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:teste_vrsoft/app/database/objectbox.g.dart';
import 'package:teste_vrsoft/app/database/student_objectbox.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class MockTest extends Mock {
  late StudentObjectBox _studentObjectBox;

  MockTest() {
    _studentObjectBox = StudentObjectBox();
  }

  Future<Box> getStudent() async {
    final store = await _studentObjectBox.getStore();
    return store.box<StudentEntity>();
  }

  Future<dynamic> createStudent(StudentEntity student, Function() func) async {
    final store = await getStudent();

    final query = store.query(StudentEntity_.name.equals(student.name)).build();
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
      // await mockTest.clearStudents();
      final student = StudentEntity(name: 'Teste');
      await mockTest.createStudent(student, () {});

      final studentsList = await mockTest.readStudent();
      expect(studentsList.length, 1);
      expect(studentsList.first.name, 'Teste');
    });

    test('Creating a student with an existing name should return a function',
        () async {
      final existingStudent = StudentEntity(name: 'Teste');
      await mockTest.createStudent(existingStudent, () {});

      final duplicateStudent = StudentEntity(name: 'Teste');
      final callback = await mockTest.createStudent(
          duplicateStudent, () => debugPrint("Usuário já existe"));

      expect(callback, isA<Function>());
    });
  });
}
