import 'package:mobx/mobx.dart';
import 'package:teste_vrsoft/app/database/entities/couse_student_entity.dart';
import 'package:teste_vrsoft/app/database/repositories/course_student_repository.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  CourseStudentRepository? _courseStudentRepository;

  _HomeStoreBase() {
    _courseStudentRepository = CourseStudentRepository();
    getAllCourseStudents().then((value) => courseStudentList.addAll(value));
  }

  ObservableList<CourseStudentEntity> courseStudentList =
      ObservableList<CourseStudentEntity>();

  @action
  Future<List<CourseStudentEntity>> getAllCourseStudents() async {
    return await _courseStudentRepository!.getAllCourseStudents();
  }

  @action
  Future<int> createCourseStudent(
      StudentEntity student, CourseEntity course) async {
    final result =
        await _courseStudentRepository!.createCourseStudent(student, course);
    // courseStudentList.add(result);
    return result;
  }
}
