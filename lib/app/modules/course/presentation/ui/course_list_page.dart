import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/course/presentation/widgets/course_card.dart';
import 'package:teste_vrsoft/app/modules/course/stores/course_store.dart';

class CourseListPage extends StatefulWidget {
  final CourseStore courseStore;
  const CourseListPage({
    Key? key,
    required this.courseStore,
  }) : super(key: key);
  @override
  CourseListPageState createState() => CourseListPageState();
}

class CourseListPageState extends State<CourseListPage> {
  CourseStore get _courseStore => widget.courseStore;
  final arguments = Modular.args.data;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 2,
          centerTitle: !arguments,
          leading: arguments
              ? IconButton(
                  onPressed: () {
                    Modular.to.pushNamedAndRemoveUntil(
                      '/redirect',
                      (_) => false,
                      arguments: arguments,
                    );
                  },
                  icon: const Icon(
                    Icons.login_outlined,
                    color: Colors.purple,
                  ),
                )
              : const SizedBox(),
          title: Text(
            "Cursos",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.purple.shade900,
            ),
          ),
          actions: [
            arguments
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
                                "isTrue": arguments,
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
