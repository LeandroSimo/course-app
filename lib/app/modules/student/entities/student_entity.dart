import 'package:objectbox/objectbox.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';

@Entity()
class StudentEntity {
  @Id(assignable: true)
  int cod;
  String name;

  final courses = ToMany<CourseEntity>();

  StudentEntity({
    this.cod = 0,
    required this.name,
  });

  bool exceededLimit() {
    return courses.length > 3;
  }
}
