import 'package:flutter/material.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';

class CourseList extends StatelessWidget {
  const CourseList({
    super.key,
    required this.size,
    required this.listCourses,
  });

  final Size size;
  final List<CourseEntity> listCourses;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.22,
      child: listCourses.isNotEmpty
          ? ListView.builder(
              itemExtent: size.width * 0.30,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: listCourses.length,
              itemBuilder: (_, index) {
                final course = listCourses[index];

                final courseNameChecked = _checkCourseName(course.name);
                final courseFullName = _checkFullName(course.name);
                final level = _checkLevelName(course.level);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 4,
                      child: Container(
                        width: size.width * 0.23,
                        height: size.height * 0.13,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            courseNameChecked.toUpperCase(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Colors.purple.shade900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      courseFullName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.purple.shade900,
                      ),
                    ),
                    Text(
                      level,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.purple.shade900,
                      ),
                    ),
                  ],
                );
              },
            )
          : Center(
              child: Text(
                'Nenhum curso matriculado',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.purple.shade900,
                ),
              ),
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

  String _checkFullName(String originalName) {
    if (originalName.length > 4) {
      return originalName.substring(0, 11);
    }
    return originalName;
  }

  String _checkLevelName(String originalName) {
    if (originalName.length > 4) {
      List<String> partes = originalName.split(RegExp(r'\s|-|/'));

      if (partes.length >= 2) {
        return '${partes[0]}\n${partes.sublist(1).join(" ")}';
      }
    }

    return originalName;
  }
}
