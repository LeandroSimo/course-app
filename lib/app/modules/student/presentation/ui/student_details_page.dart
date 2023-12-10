import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:teste_vrsoft/app/modules/student/stores/student_store.dart';

class StudentDetailsPage extends StatefulWidget {
  final StudentEntity student;
  final StudentStore studentStore;
  const StudentDetailsPage({
    super.key,
    required this.studentStore,
    required this.student,
  });

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  StudentStore get controller => widget.studentStore;

  TextEditingController firstNameEditController = TextEditingController();
  TextEditingController lastNameEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final studentEntity = controller.studentList.firstWhere(
      (element) => element.cod == widget.student.cod,
      orElse: () => widget.student,
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Modular.to.pushReplacementNamed('/student/');
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.purple,
            ),
          ),
          title: Text(
            "Conta",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.purple.shade900,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                firstNameEditController.value =
                    TextEditingValue(text: studentEntity.firstName);
                lastNameEditController.value =
                    TextEditingValue(text: studentEntity.lastName);
                _showAlertDialog(context, size, widget.student);
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.purple,
              ),
            ),
          ],
        ),
        body: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Text(
                    _checkName(widget.student.firstName),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const Gap(20),
                Observer(builder: (context) {
                  return Text(
                    "${studentEntity.firstName} ${studentEntity.lastName}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.purple.shade900,
                    ),
                  );
                }),
                const Gap(20),
                Divider(
                  color: Colors.grey.shade400,
                  thickness: 1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Cursos matriculados",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.purple.shade900,
                        ),
                      ),
                    ),
                    const Gap(20),
                    Container(
                      height: widget.student.courses.isNotEmpty
                          ? size.height
                          : size.height * 0.3,
                      width: size.width,
                      padding: const EdgeInsets.all(10),
                      color: Colors.grey.shade200,
                      child: widget.student.courses.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.student.courses.length,
                              itemBuilder: (context, index) {
                                final course = widget.student.courses[index];
                                return ListTile(
                                  title: Text(
                                    course.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.purple.shade900,
                                    ),
                                  ),
                                  subtitle: Text(
                                    course.description,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.purple.shade900,
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                "Nenhum curso cadastrado",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.purple.shade900,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _checkName(String originalName) {
    if (originalName.contains(' ')) {
      final parts = originalName.split(' ');
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}';
      }
    }
    if (originalName.length > 4) {
      return originalName.substring(0, 2).toUpperCase();
    }
    return originalName.toUpperCase();
  }

  _showAlertDialog(BuildContext context, Size size, StudentEntity student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: size.height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Editar Aluno',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: firstNameEditController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Nome',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                ),
                // const SizedBox(height: 10),
                TextField(
                  controller: lastNameEditController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Sobrenome',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.updateStudent(
                      StudentEntity(
                        cod: student.cod,
                        firstName: firstNameEditController.text,
                        lastName: lastNameEditController.text,
                      ),
                    );
                    Modular.to.pop(context);
                  },
                  child: const Text("Editar Aluno"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
