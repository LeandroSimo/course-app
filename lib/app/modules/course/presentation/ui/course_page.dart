import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter_modular/flutter_modular.dart';
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
  final CourseStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Observer(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Modular.to.pushNamedAndRemoveUntil("/", (p0) => false);
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
                  onPressed: () {},
                ),
              ),
            ],
          ),
          body: Container(
            padding: EdgeInsets.only(
              top: _size.height * 0.02,
              left: 2,
              right: 2,
            ),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: _courseStore.courseList.isNotEmpty
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: _courseStore.courseList.length,
                    itemBuilder: (_, index) {
                      final course = _courseStore.courseList[index];

                      final color = _courseStore.courseList.isNotEmpty
                          ? int.parse(course.courseBackGroundColor
                              .toString()
                              .replaceAll('#', '0xFF'))
                          : 0xFF000000;
                      final _courseName =
                          _checkCourseName(course.name.toString());

                      return Card(
                        elevation: 4,
                        child: Container(
                          width: _size.width * 0.22,
                          height: _size.height * 0.12,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text("${course.name}"),
                        ),
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
          ),
        );
      }),
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
