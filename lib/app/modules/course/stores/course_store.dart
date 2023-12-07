import 'package:mobx/mobx.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/course/repositories/course_repository.dart';

part 'course_store.g.dart';

class CourseStore = _CourseStoreBase with _$CourseStore;

abstract class _CourseStoreBase with Store {
  CourseRepository? _courseRepository;

  _CourseStoreBase() {
    _courseRepository = CourseRepository();
    getAllCourse().then((value) => courseList.addAll(value));
  }
  ObservableList<CourseEntity> courseList = ObservableList<CourseEntity>();

  @action
  Future<List<CourseEntity>> getAllCourse() async {
    return await _courseRepository!.readCourse();
  }

  @action
  Future<int> createCourse(CourseEntity course) async {
    final result = await _courseRepository!.createCourse(course);
    courseList.add(course);
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
}
