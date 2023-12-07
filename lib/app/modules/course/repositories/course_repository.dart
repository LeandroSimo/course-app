import 'package:objectbox/objectbox.dart';
import 'package:teste_vrsoft/app/database/student_objectbox.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';

class CourseRepository {
  late CourseStudentObjectBox _studentObjectBox;

  CourseRepository() {
    _studentObjectBox = CourseStudentObjectBox();
  }

  Future<Box> getStudent() async {
    final store = await _studentObjectBox.getStore();
    return store.box<CourseEntity>();
  }

  Future<int> createCourse(CourseEntity course) async {
    final store = await getStudent();
    return store.put(course);
  }

  Future<List<CourseEntity>> readCourse() async {
    final store = await getStudent();
    return store.getAll() as List<CourseEntity>;
  }

  Future<int> updateCourse(CourseEntity course) async {
    final store = await getStudent();
    return store.put(course);
  }

  Future<void> deleteCourse(CourseEntity course) async {
    final store = await getStudent();
    store.remove(course.cod);
  }
}