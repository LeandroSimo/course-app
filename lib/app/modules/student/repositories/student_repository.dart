import 'package:teste_vrsoft/app/database/objectbox.g.dart';
import 'package:teste_vrsoft/app/database/student_objectbox.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';

class StudentRepository {
  late CourseStudentObjectBox _studentObjectBox;

  StudentRepository() {
    _studentObjectBox = CourseStudentObjectBox();
  }

  Future<Box> getStudent() async {
    final store = await _studentObjectBox.getStore();
    return store.box<StudentEntity>();
  }

  Future<int> createStudent(StudentEntity student) async {
    final store = await getStudent();
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

  Future<bool> addCourserToStudent(CourseEntity course,
      {StudentEntity? student}) async {
    return student!.addCourseToStudent(course);
  }

  Future<List<CourseEntity>> getCoursesByStudent(StudentEntity student) async {
    final store = await getStudent();
    final studentEntity = store.get(student.cod) as StudentEntity;
    return studentEntity.courses.toList();
  }
}
