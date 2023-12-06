import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/student/presentation/widgets/course_list_student.dart';

class StudentDetailsPage extends StatefulWidget {
  const StudentDetailsPage({super.key});

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
              Modular.to.pop();
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

class GridViewCoursesProgress extends StatelessWidget {
  const GridViewCoursesProgress({
    super.key,
    required this.size,
    required this.coursesProgress,
  });

  final Size size;
  final List coursesProgress;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: coursesProgress.length,
        itemBuilder: (_, index) {
          final course = coursesProgress[index];

          final color = coursesProgress[index].isNotEmpty
              ? int.parse(course['color'].toString().replaceAll('#', '0xFF'))
              : 0xFF000000;
          final _coursesProgress = _checkCourseName(course['name'].toString());
          final _percent = course['percent'];
          final progress = course['progress'].toString();

          return Card(
            elevation: 4,
            child: Container(
              width: size.width * 0.22,
              height: size.height * 0.12,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    _coursesProgress,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Color(color),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Progresso",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple.shade900,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text.rich(
                        TextSpan(
                          text: progress,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange.shade700,
                          ),
                          children: [
                            TextSpan(
                              text: "/35",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.purple.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: _percent,
                    minHeight: 10,
                    backgroundColor: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.orange.shade400,
                    ),
                  )
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
    return originalName;
  }
}
