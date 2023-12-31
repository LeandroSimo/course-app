import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/course/stores/course_store.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:teste_vrsoft/app/modules/student/stores/student_store.dart';

class CourseDetails extends StatefulWidget {
  final StudentStore studentStore;
  final CourseStore courseStore;
  const CourseDetails({
    super.key,
    required this.studentStore,
    required this.courseStore,
  });

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  StudentStore get _studentStore => widget.studentStore;
  CourseStore get _courseStore => widget.courseStore;

  final arguments = Modular.args.data;

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final CourseEntity course = arguments["course"] as CourseEntity;
    final bool isAdm = arguments["isAdm"] as bool;
    final StudentEntity studentEntity = arguments["student"] ??
        StudentEntity(
          firstName: "",
          lastName: "",
          cod: 0,
        );

    final student = _studentStore.studentList.firstWhere(
        (element) => element.cod == studentEntity.cod,
        orElse: () => studentEntity);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Modular.to.pushNamedAndRemoveUntil(
                '/course/',
                (_) => false,
                arguments: {
                  "isAdm": isAdm,
                  "student": student,
                },
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.purple,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: Colors.purple,
              ),
            ),
          ],
        ),
        body: Observer(builder: (context) {
          return Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * 0.3,
                    width: size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      size: size.height * 0.1,
                      color: Colors.purple.shade900,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    course.name,
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        course.description,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _controller.text = course.description.toString();
                          showDialogEditeCourse(
                            controller: _controller,
                            title: "Editar carga horária",
                            label: "Carga horária",
                            onPressed: () {
                              _courseStore.updateCourse(
                                CourseEntity(
                                  cod: course.cod,
                                  name: course.name,
                                  description: _controller.text,
                                  schedule: course.schedule,
                                  level: course.level,
                                  hours: course.hours,
                                ),
                              );
                              Modular.to.pushNamedAndRemoveUntil(
                                '/course/',
                                (p0) => false,
                                arguments: {
                                  "isAdm": isAdm,
                                  "student": student,
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),

                  const Text(
                    'Carga horária',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${course.hours.toString()}h",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ementa do curso',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      isAdm
                          ? IconButton(
                              onPressed: () {
                                _controller.text = course.schedule.toString();
                                showDialogEditeCourse(
                                  controller: _controller,
                                  title: "Editar ementa",
                                  label: "Ementa",
                                  onPressed: () {
                                    _courseStore.updateCourse(
                                      CourseEntity(
                                        cod: course.cod,
                                        name: course.name,
                                        description: course.description,
                                        schedule: _controller.text,
                                        level: course.level,
                                        hours: course.hours,
                                      ),
                                    );
                                    Modular.to.pushNamedAndRemoveUntil(
                                      '/course/',
                                      (p0) => false,
                                      arguments: {
                                        "isAdm": isAdm,
                                        "student": student,
                                      },
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.edit),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  // const SizedBox(height: 5),
                  Text(
                    course.schedule,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Nível',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    course.level,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  !isAdm
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: size.height * 0.09,
                              width: size.width * 0.93,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple.shade900,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () async {
                                  addCourse(context, course, student);
                                  Modular.to.pushNamedAndRemoveUntil(
                                    '/home/',
                                    (_) => false,
                                    arguments: student,
                                  );
                                },
                                child: const Text(
                                  'Matricular-se',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  addCourse(
      BuildContext context, CourseEntity course, StudentEntity student) async {
    final value = _studentStore.courseListStudent
        .where((element) => element.cod == course.cod);

    if (_studentStore.courseListStudent.length < 3) {
      final succsess = await _studentStore.addCourseToStudent(student, course);

      _courseStore.addStudentToCourse(course, student);

      succsess != -1 ? onSuccsess() : onMessageError("Erro ao matricular-se");
    } else if (value.isNotEmpty) {
      onMessageError("Você já está matriculado nesse curso");
    } else {
      onMessageError("Você não pode se matricular em mais de 3 cursos");
    }
  }

  onSuccsess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Matriculado com sucesso",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  onMessageError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  showDialogEditeCourse({
    required TextEditingController controller,
    required String title,
    required String label,
    required Function() onPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => onPressed(),
              child: const Text("Salvar"),
            ),
          ],
        );
      },
    );
  }
}
