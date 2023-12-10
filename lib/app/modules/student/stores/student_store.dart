import 'package:mobx/mobx.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:teste_vrsoft/app/modules/student/repositories/student_repository.dart';

part 'student_store.g.dart';

class StudentStore = _StudentStoreBase with _$StudentStore;

abstract class _StudentStoreBase with Store {
  StudentRepository? _studentRepository;

  _StudentStoreBase() {
    _studentRepository = StudentRepository();
    getAllStudent().then((value) => studentList.addAll(value));
    courseListStudent = ObservableList<CourseEntity>();
  }

  ObservableList<StudentEntity> studentList = ObservableList<StudentEntity>();
  ObservableList<CourseEntity> courseListStudent =
      ObservableList<CourseEntity>();

  @action
  Future<List<StudentEntity>> getAllStudent() async {
    return await _studentRepository!.readStudent();
  }

  @action
  Future<int> createStudent(StudentEntity student) async {
    final result = await _studentRepository!.createStudent(student);
    studentList.add(student);
    return result;
  }

  @action
  Future<int> updateStudent(StudentEntity student) async {
    int result = await _studentRepository!.updateStudent(student);

    var index = studentList.indexWhere((element) => element.cod == result);
    if (index != -1) {
      studentList[index] = student;
    }

    return result;
  }

  @action
  void removeStudent(StudentEntity student) {
    _studentRepository!.deleteStudent(student);
    studentList.remove(student);
  }

  @action
  Future<int> addCourseToStudent(
      StudentEntity student, CourseEntity course) async {
    final result =
        await _studentRepository!.addCourserToStudent(student, course);
    if (result != -1) {
      courseListStudent.add(course);
      final value = student.courses.firstWhere(
        (element) => element.cod == student.cod,
        orElse: () => course,
      );

      print("VALOR DO VALUE: ${value.students.length}");
      // print(
      //     "VALOR DO VALUE: ${value.students.firstWhere((element) => element.cod == student.cod)}");

      if (value.cod == student.cod) {
        studentList.add(student);
      }
    }
    return result;
  }
}
