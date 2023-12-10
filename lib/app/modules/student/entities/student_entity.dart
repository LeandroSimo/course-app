import 'package:objectbox/objectbox.dart';
import 'package:teste_vrsoft/app/database/objectbox.g.dart';
import 'package:teste_vrsoft/app/database/repositories/course_student_repository.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';

@Entity()
class StudentEntity {
  @Id(assignable: true)
  int cod;
  String firstName;
  String lastName;

  final courses = ToMany<CourseEntity>();

  StudentEntity({
    this.cod = 0,
    required this.firstName,
    required this.lastName,
  });

  bool exceededLimit() {
    return courses.length > 3;
  }

  bool addCourseToStudent(CourseEntity course) {
    if (!exceededLimit() &&
        !courses.contains(course) &&
        !course.isFullClass()) {
      courses.add(course);
      course.addStudentToCourse(this);
      course.saveToCourseStudentTable(this);
      return true;
    }
    return false;
  }

  Future<void> saveToCourseStudentTable(CourseEntity course) async {
    final courseStudentEntity = CourseStudentRepository();
    courseStudentEntity.createCourseStudent(this, course);
  }
}
