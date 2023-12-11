import 'package:flutter/material.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/course/stores/course_store.dart';
import 'package:teste_vrsoft/app/modules/student/stores/student_store.dart';

class CardCourse extends StatefulWidget {
  final CourseEntity course;
  final CourseStore courseStore;
  final Size size;
  final Function() onTap;
  final StudentStore studentStore;

  const CardCourse({
    super.key,
    required this.course,
    required this.size,
    required this.onTap,
    required this.studentStore,
    required this.courseStore,
  });

  @override
  State<CardCourse> createState() => _CardCourseState();
}

class _CardCourseState extends State<CardCourse> {
  @override
  Widget build(BuildContext context) {
    final courseName =
        _checkCourseName(widget.course.name.toString().toUpperCase());
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  child: Container(
                    width: widget.size.width * 0.13,
                    height: widget.size.height * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade900,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        courseName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.course.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          widget.course.schedule.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${widget.course.hours} horas",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          widget.course.level.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          "${widget.course.students.length.toString()} Alunos matriculados",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const Text(
                          "GRÁTIS",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Checkbox(
                  value: widget.studentStore.selectedIndices.contains(
                      widget.key.hashCode %
                          widget.courseStore.courseList.length),
                  onChanged: (bool? value) {
                    setState(() {
                      int index = widget.key.hashCode %
                          widget.courseStore.courseList.length;
                      index = index >= 0
                          ? index
                          : index + widget.courseStore.courseList.length;

                      if (value != null && value) {
                        widget.studentStore.selectedIndices.add(index);
                      } else {
                        widget.studentStore.selectedIndices.remove(index);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
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
    if (originalName.length >= 3) {
      return originalName.substring(0, 1);
    }
    return originalName;
  }
}
