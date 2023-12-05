import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
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

  TextEditingController nameController = TextEditingController();
  TextEditingController nameEditController = TextEditingController();

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
                  controller: nameController,
                  // onChanged: widget.controller.setName,
                ),
                ElevatedButton(
                  onPressed: () => controller.createStudent(
                    StudentEntity(
                      name: nameController.text,
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
                        title: Text(student.name),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                nameEditController.value = TextEditingValue(
                                  text: student.name,
                                );
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: TextField(
                                        controller: nameEditController,
                                        // onChanged: widget.controller.setName,
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.updateStudent(
                                              StudentEntity(
                                                cod: student.cod,
                                                name: nameEditController.text,
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
