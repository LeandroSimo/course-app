import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';

class CourseDto {
  int cod;
  String name;
  String description;
  String schedule;
  String level;

  CourseDto({
    required this.cod,
    required this.name,
    required this.description,
    required this.schedule,
    required this.level,
  });

  factory CourseDto.fromEntity(CourseEntity entity) {
    return CourseDto(
      cod: entity.cod,
      name: entity.name,
      description: entity.description,
      schedule: entity.schedule,
      level: entity.level,
    );
  }
}
