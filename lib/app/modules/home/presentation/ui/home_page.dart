import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/course/stores/course_store.dart';
import 'package:teste_vrsoft/app/modules/home/presentation/widgets/list_course_home.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:teste_vrsoft/app/modules/student/presentation/widgets/course_list_student.dart';
import 'package:teste_vrsoft/app/modules/student/presentation/widgets/list_view_courses_progress.dart';
import 'package:teste_vrsoft/app/modules/student/stores/student_store.dart';

class HomePage extends StatefulWidget {
  final StudentEntity student;
  final CourseStore courseStore;
  final StudentStore studentStore;
  const HomePage({
    super.key,
    required this.student,
    required this.courseStore,
    required this.studentStore,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CourseStore get courseStore => widget.courseStore;
  StudentStore get studentStore => widget.studentStore;

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
  void didChangeDependencies() {
    super.didChangeDependencies();

    courseStore.getAllCourse().then((value) {
      studentStore.studentList.forEach((student) {
        student.courses.forEach((course) {
          var index = value.indexWhere((element) => element.cod == course.cod);
          if (index != -1) {
            student.courses[index] = value[index];
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    StudentEntity student = widget.student;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Modular.to.pushReplacementNamed(Modular.initialRoute);
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.purple,
            ),
          ),
          title: Text(
            student.firstName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.purple.shade900,
            ),
          ),
        ),
        body: Observer(builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Seus cursos",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple.shade900,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Modular.to.navigate(
                            '/course/',
                            arguments: {
                              "student": student,
                              "isAdm": false,
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.add_box,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  CourseList(
                    size: size,
                    listCourses: widget.student.courses,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Alguns dos nossos cursos",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple.shade900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListCourseHome(
                    courseStore: courseStore,
                    size: size,
                  ),
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
                  ListViewCoursesProgress(
                      size: size, coursesProgress: coursesProgress)
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
