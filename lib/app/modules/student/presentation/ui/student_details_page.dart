import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:teste_vrsoft/app/modules/student/presentation/widgets/course_list_student.dart';
import 'package:teste_vrsoft/app/modules/student/presentation/widgets/grid_view_courses_progress.dart';

class StudentDetailsPage extends StatefulWidget {
  final StudentEntity student;
  const StudentDetailsPage({
    super.key,
    required this.student,
  });

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  final List<Map> _courses = [
    {
      "name": "Java Script",
      "level": "Básico",
      "color": "#F9CA24",
    },
    {
      "name": "PHP",
      "level": "Intermediário",
      "color": "#9E92FE",
    },
    {
      "name": "CSS",
      "level": "Avançado",
      "color": "#74B8FF",
    },
  ];
  final List<Map> coursesProgress = [
    {
      "name": "Java Script",
      "level": "Básico",
      "color": "#FAC91E",
      "percent": 0.5,
      "progress": "18"
    },
    {
      "name": "PHP",
      "level": "Intermediário",
      "color": "#9B8EFF",
      "percent": 0.3,
      "progress": "10"
    },
    {
      "name": "CSS",
      "level": "Avançado",
      "color": "#76BCFF",
      "percent": 0.7,
      "progress": "29"
    },
    {
      "name": "SQL",
      "level": "Avançado",
      "color": "#53A1FF",
      "percent": 0.9,
      "progress": "32"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Modular.to.pushNamedAndRemoveUntil("/student/", (p0) => false);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.purple,
            ),
          ),
          title: Text(
            'Perfil',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.purple.shade900,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cursos matriculados",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.purple.shade900,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Modular.to.pushNamed('/student/courses');
                    },
                    icon: const Icon(
                      Icons.add_box,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
              CourseList(size: _size, courses: _courses),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Seu progesso",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.purple.shade900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GridViewCoursesProgress(
                  size: _size, coursesProgress: coursesProgress)
            ],
          ),
        ),
      ),
    );
  }
}
