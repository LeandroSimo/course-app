import 'package:teste_vrsoft/app/database/objectbox.g.dart';
import 'package:teste_vrsoft/app/database/student_objectbox.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';

class StudentRepository {
  late StudentObjectBox _studentObjectBox;

  StudentRepository() {
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
      return func();
    }
    query.close();
    return store.put(student);
  }

  Future<List<StudentEntity>> readStudent() async {
    final store = await getStudent();
    return store.getAll() as List<StudentEntity>;
  }

  Future<int> updateStudent(StudentEntity student) async {
    final store = await getStudent();
    return store.put(student);
  }

  Future<void> deleteStudent(StudentEntity student) async {
    final store = await getStudent();
    store.remove(student.cod);
  }
}
