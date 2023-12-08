import 'package:objectbox/objectbox.dart';
import 'package:teste_vrsoft/app/database/objectbox.g.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/course_student/entities/couse_student_entity.dart';

Store _store = Store(getObjectBoxModel());

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

  void saveToCourseStudentTable(CourseEntity course) {
    final courseStudentEntity = CourseStudentEntity(
      student: ToOne<StudentEntity>()..target = this,
      course: ToOne<CourseEntity>()..target = course,
    );
    _store.box<CourseStudentEntity>().put(courseStudentEntity);
  }
}
