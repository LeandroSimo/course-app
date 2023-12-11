import 'package:flutter/material.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';

class ListCourseHome extends StatelessWidget {
  const ListCourseHome({
    super.key,
    required this.size,
    required this.courses,
  });

  final Size size;
  final List<CourseEntity> courses;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.46,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (_, index) {
          final course = courses[index];
          return Card(
            elevation: 4,
            child: Container(
              width: size.width * 0.60,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width * 0.60,
                    height: size.height * 0.20,
                    decoration: BoxDecoration(
                      // color: Colors.purple.shade900,
                      border: Border.all(
                        color: Colors.grey.shade400,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        _checkCourseName(course.name),
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w800,
                          color: Colors.purple.shade900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.purple.shade900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.level.toUpperCase(),
                    style: TextStyle(
                      fontSize: 13,
                      // fontWeight: FontWeight.w400,
                      color: Colors.purple.shade900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Carga horária: ${course.hours} horas",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.purple.shade900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  course.students.length < 5
                      ? DecoratedBox(
                          decoration: BoxDecoration(
                            color: course.students.isEmpty
                                ? Colors.green.shade500
                                : course.students.length <= 9
                                    ? Colors.yellow.shade800
                                    : Colors.red.shade600,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: SizedBox(
                            height: size.height * 0.05,
                            width: size.width * 0.3,
                            child: Center(
                              child: Text(
                                course.students.isEmpty
                                    ? 'Turma disponível'
                                    : course.students.length <= 9
                                        ? 'Últimas vagas'
                                        : 'Turma fechada',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _checkCourseName(String originalName) {
    if (originalName.contains(' ')) {
      final parts = originalName.split(' ');
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}';
      }
    }
    if (originalName.length > 4) {
      return originalName.substring(0, 4);
    }
    return originalName;
  }
}
