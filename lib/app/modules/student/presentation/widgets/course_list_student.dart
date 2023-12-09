import 'package:flutter/material.dart';

class CourseList extends StatelessWidget {
  const CourseList({
    super.key,
    required this.courses,
    required this.size,
  });

  final Size size;
  final List courses;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.19,
      child: courses.isNotEmpty
          ? ListView.builder(
              itemExtent: size.width * 0.30,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: courses.length,
              itemBuilder: (_, index) {
                final course = courses[index];
                final color = courses[index].isNotEmpty
                    ? int.parse(
                        course['color'].toString().replaceAll('#', '0xFF'))
                    : 0xFF000000;
                final courseNameChecked =
                    _checkCourseName(course['name'].toString());
                final fullName = course['name'].toString();
                final level = course['level'].toString();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 4,
                      child: Container(
                        width: size.width * 0.22,
                        height: size.height * 0.12,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(color),
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
                      fullName,
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
}
