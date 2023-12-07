import 'package:objectbox/objectbox.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';

@Entity()
class CourseStudentEntity {
  @Id(assignable: true)
  final int cod;

  late final ToOne<StudentEntity> student;
  late final ToOne<CourseEntity> course;

  CourseStudentEntity({
    this.cod = 0,
    required this.student,
    required this.course,
  });
}
