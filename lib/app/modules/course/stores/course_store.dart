import 'package:mobx/mobx.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/course/repositories/course_repository.dart';

part 'course_store.g.dart';

class CourseStore = _CourseStoreBase with _$CourseStore;

abstract class _CourseStoreBase with Store {
  CourseRepository? _courseRepository;

  ObservableList<CourseEntity> courseList = ObservableList<CourseEntity>();

  _CourseStoreBase() {
    _courseRepository = CourseRepository();
    getAllStudent().then((value) => courseList.addAll(value));
  }

  @action
  Future<List<CourseEntity>> getAllStudent() async {
    return await _courseRepository!.readCourse();
  }

  @action
  Future<int> createCourse(CourseEntity course) async {
    return await _courseRepository!.createCourse(course);
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
