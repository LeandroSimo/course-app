import 'package:objectbox/objectbox.dart';
import 'package:teste_vrsoft/app/database/objectbox.g.dart';
import 'package:teste_vrsoft/app/modules/course_student/entities/couse_student_entity.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';

Store _store = Store(getObjectBoxModel());

@Entity()
class CourseEntity {
  @Id(assignable: true)
  int cod;
  String name;
  String description;
  String schedule;
  String level;

  final students = ToMany<StudentEntity>();

  CourseEntity({
    this.cod = 0,
    required this.name,
    required this.description,
    required this.schedule,
    required this.level,
  });

  bool isFullClass() {
    return students.length >= 10;
  }

  bool isClosedClass() {
    return students.length < 5;
  }

  bool addStudent(StudentEntity student) {
    if (!isFullClass() &&
        !students.contains(student) &&
        !student.exceededLimit()) {
      students.add(student);
      return true;
    }
    return false;
  }

  void saveToCourseStudentTable(StudentEntity student) {
    final courseStudentEntity = CourseStudentEntity(
      student: ToOne<StudentEntity>()..target = student,
      course: ToOne<CourseEntity>()..target = this,
    );
    addStudent(student);
    _store.box<CourseStudentEntity>().put(courseStudentEntity);
  }
}
