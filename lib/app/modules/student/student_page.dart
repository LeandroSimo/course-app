import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:teste_vrsoft/app/modules/student/stores/student_store.dart';
import 'package:flutter/material.dart';

class StudentPage extends StatefulWidget {
  final StudentStore controller;
  final String title;
  StudentPage({
    this.title = 'StudentPage',
    required this.controller,
  });

  @override
  StudentPageState createState() => StudentPageState();
}

class StudentPageState extends State<StudentPage> {
  StudentStore get controller => widget.controller;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController firstNameEditController = TextEditingController();
  TextEditingController lastNameEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Observer(
          builder: (context) {
            return Column(
              children: <Widget>[
                TextField(
                  controller: firstNameController,
                ),
                TextField(
                  controller: lastNameController,
                ),
                ElevatedButton(
                  onPressed: () => controller.createStudent(
                    StudentEntity(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                    ),
                    func: () {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: Text("Aluno já cadastrado"),
                          );
                        },
                      );
                    },
                  ),
                  child: const Text("Adicionar Aluno"),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.studentList.length,
                    itemBuilder: (_, index) {
                      final student = controller.studentList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          child: Text(
                            "${student.firstName[0].substring(0)}${student.lastName[0].substring(0)}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        title: Text(
                          student.firstName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            // fontSize: 18,
                          ),
                        ),
                        subtitle: Text(student.lastName),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                firstNameEditController.value =
                                    TextEditingValue(
                                  text: student.firstName,
                                );
                                lastNameEditController.value =
                                    TextEditingValue(text: student.lastName);

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Column(
                                        children: [
                                          TextField(
                                            controller: firstNameEditController,
                                          ),
                                          TextField(
                                            controller: lastNameEditController,
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.updateStudent(
                                              StudentEntity(
                                                cod: student.cod,
                                                firstName:
                                                    firstNameEditController
                                                        .text,
                                                lastName:
                                                    lastNameEditController.text,
                                              ),
                                            );
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Editar Aluno"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                controller.removeStudent(student);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                        //  IconButton(
                        //   icon: Icon(Icons.delete),
                        //   onPressed: () => controller.removeStudent(student),
                        // ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
