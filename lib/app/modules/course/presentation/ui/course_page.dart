import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/course/presentation/widgets/course_card.dart';
import 'package:teste_vrsoft/app/modules/course/stores/course_store.dart';

class CoursePage extends StatefulWidget {
  final CourseStore courseStore;
  const CoursePage({
    Key? key,
    required this.courseStore,
  }) : super(key: key);
  @override
  CoursePageState createState() => CoursePageState();
}

class CoursePageState extends State<CoursePage> {
  CourseStore get _courseStore => widget.courseStore;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 2,
          leading: IconButton(
            onPressed: () {
              Modular.to.pushNamedAndRemoveUntil("/", (_) => false);
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
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ElevatedButton(
                child: const Text("Adicionar"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  Modular.to.pushNamed("/course/add");
                },
              ),
            ),
          ],
        ),
        body: Observer(builder: (context) {
          return Container(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: _courseStore.courseList.isNotEmpty
                ? ListView.builder(
                    itemCount: _courseStore.courseList.length,
                    itemBuilder: (_, index) {
                      final course = _courseStore.courseList[index];

                      return CardCourse(course: course, size: _size);
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
        }),
      ),
    );
  }
}
