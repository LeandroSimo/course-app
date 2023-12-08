import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';

class StudentDto {
  int? cod;
  String firstName;
  String lastName;

  StudentDto({
    this.cod,
    required this.firstName,
    required this.lastName,
  });

  factory StudentDto.fromEntity(StudentEntity entity) {
    return StudentDto(
      cod: entity.cod,
      firstName: entity.firstName,
      lastName: entity.lastName,
    );
  }
}
