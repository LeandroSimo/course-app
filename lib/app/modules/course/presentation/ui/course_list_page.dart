import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/course/presentation/widgets/course_card.dart';
import 'package:teste_vrsoft/app/modules/course/stores/course_store.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:teste_vrsoft/app/modules/student/stores/student_store.dart';

class CourseListPage extends StatefulWidget {
  final CourseStore courseStore;
  final StudentStore studentStore;
  const CourseListPage({
    Key? key,
    required this.courseStore,
    required this.studentStore,
  }) : super(key: key);
  @override
  CourseListPageState createState() => CourseListPageState();
}

class CourseListPageState extends State<CourseListPage> {
  CourseStore get _courseStore => widget.courseStore;
  StudentStore get _studentStore => widget.studentStore;
  final arguments = Modular.args.data;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    final bool isAdm = arguments["isAdm"];
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
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 2,
          centerTitle: !isAdm,
          leading: isAdm
              ? IconButton(
                  onPressed: () {
                    Modular.to.pushNamedAndRemoveUntil(
                      '/redirect',
                      (_) => false,
                      arguments: {"isAdm": isAdm},
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.purple,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    Modular.to.pushNamedAndRemoveUntil(
                      '/home',
                      (_) => false,
                      arguments: student,
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.purple,
                  ),
                ),
          title: Text(
            "Cursos",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.purple.shade900,
            ),
          ),
          actions: [
            isAdm
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ElevatedButton(
                      child: const Text("Adicionar"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        Modular.to.navigate("/course/add");
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        body: Observer(
          builder: (context) {
            return Container(
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: _courseStore.courseList.isNotEmpty
                  ? ListView.builder(
                      itemCount: _courseStore.courseList.length,
                      itemBuilder: (_, index) {
                        final course = _courseStore.courseList[index];
                        return CardCourse(
                          course: course,
                          size: _size,
                          onTap: () {
                            Modular.to.navigate(
                              "/course/details",
                              arguments: {
                                "course": course,
                                "isAdm": isAdm,
                              },
                            );
                          },
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        "Nenhum curso cadastrado",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
