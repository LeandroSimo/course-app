import 'package:teste_vrsoft/app/database/objectbox.g.dart';
import 'package:teste_vrsoft/app/database/repositories/course_student_repository.dart';
import 'package:teste_vrsoft/app/database/student_objectbox.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';

class StudentRepository {
  late CourseStudentObjectBox _studentObjectBox;
  late CourseStudentRepository _courseStudentRepository;

  StudentRepository() {
    _studentObjectBox = CourseStudentObjectBox();
    _courseStudentRepository = CourseStudentRepository();
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

  Future<List<CourseEntity>> getCoursesByStudent(StudentEntity student) async {
    final store = await getStudent();
    final studentEntity = store.get(student.cod) as StudentEntity;
    return studentEntity.courses.toList();
  }

  Future<int> addCourserToStudent(
      StudentEntity student, CourseEntity course) async {
    final store = await getStudent();

    bool isExceeded = student.courses.length > 3;

    if (!isExceeded &&
        !student.courses.contains(course) &&
        !course.students.contains(student)) {
      student.courses.add(course);
      _courseStudentRepository.createCourseStudent(student, course);
    }
    return store.put(student);
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
