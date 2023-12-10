import 'package:objectbox/objectbox.dart';
import 'package:teste_vrsoft/app/database/objectbox.g.dart';
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
}
