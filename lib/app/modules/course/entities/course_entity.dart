import 'package:objectbox/objectbox.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';

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
}
