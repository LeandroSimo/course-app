import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({
    super.key,
  });

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  final arguments = Modular.args.data;
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final CourseEntity ourse = arguments["course"] as CourseEntity;
    final bool isAdm = arguments["isAdm"] as bool;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Modular.to.pushNamedAndRemoveUntil(
                '/course/',
                (_) => false,
                arguments: {"isAdm": isAdm},
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
        body: Container(
          height: _size.height,
          width: _size.width,
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: _size.height * 0.3,
                  width: _size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    size: _size.height * 0.1,
                    color: Colors.purple.shade900,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  ourse.name,
                  style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  ourse.description,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Conteúdo do curso',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    isAdm
                        ? IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                          )
                        : const SizedBox(),
                  ],
                ),
                // const SizedBox(height: 5),
                Text(
                  ourse.schedule,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Nível',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    isAdm
                        ? IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit),
                          )
                        : const SizedBox(),
                  ],
                ),
                Text(
                  ourse.level,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: _size.height * 0.09,
                      width: _size.width * 0.95,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // widget.courseStore.addStudentToCourse(student, _course)
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
