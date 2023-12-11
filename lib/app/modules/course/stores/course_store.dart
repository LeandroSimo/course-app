import 'package:mobx/mobx.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/course/repositories/course_repository.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';

part 'course_store.g.dart';

class CourseStore = _CourseStoreBase with _$CourseStore;

abstract class _CourseStoreBase with Store {
  CourseRepository? _courseRepository;

  _CourseStoreBase() {
    _courseRepository = CourseRepository();
    getAllCourse();
  }

  @observable
  List<CourseEntity> courseList = [];

  @action
  Future<List<CourseEntity>> getAllCourse() async {
    final course = await _courseRepository!.readCourse();
    courseList = List.from(course);
    return course;
  }

  @action
  Future<int> createCourse(CourseEntity course) async {
    final result = await _courseRepository!.createCourse(course);
    courseList = List.from(courseList..add(course));

    getAllCourse();
    return result;
  }

  @action
  Future<int> updateCourse(CourseEntity course) async {
    int result = await _courseRepository!.updateCourse(course);

    var index = courseList.indexWhere((element) => element.cod == result);
    if (index != -1) {
      courseList[index] = course;
    }

    return result;
  }

  @action
  void removeCourse(CourseEntity course) {
    _courseRepository!.deleteCourse(course);
    courseList.remove(course);
  }

  @action
  Future<int> addStudentToCourse(
      CourseEntity course, StudentEntity student) async {
    final result = await _courseRepository!.addStudentToCourse(course, student);

    if (result != 0) {
      course.students.add(student);
    }

    return result;
  }
}
