import 'package:objectbox/objectbox.dart';
import 'package:teste_vrsoft/app/database/student_objectbox.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';

class CourseRepository {
  late CourseStudentObjectBox _studentObjectBox;

  CourseRepository() {
    _studentObjectBox = CourseStudentObjectBox();
  }

  Future<Box> getCourse() async {
    final store = await _studentObjectBox.getStore();
    return store.box<CourseEntity>();
  }

  Future<int> createCourse(CourseEntity course) async {
    final store = await getCourse();
    return store.put(course);
  }

  Future<List<CourseEntity>> readCourse() async {
    final store = await getCourse();
    return store.getAll() as List<CourseEntity>;
  }

  Future<int> updateCourse(CourseEntity course) async {
    final store = await getCourse();
    return store.put(course);
  }

  Future<void> deleteCourse(CourseEntity course) async {
    final store = await getCourse();
    store.remove(course.cod);
  }

  Future<int> addStudentToCourse(
    CourseEntity course,
    StudentEntity student,
  ) async {
    final store = await getCourse();
    course.addStudentToCourse(student);
    return store.put(course);
  }
}
