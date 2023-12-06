import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:teste_vrsoft/app/modules/student/presentation/ui/add_student_page.dart';
import 'package:teste_vrsoft/app/modules/student/presentation/widgets/student_list_tile.dart';
import 'package:teste_vrsoft/app/modules/student/stores/student_store.dart';
import 'package:flutter/material.dart';

class StudentPage extends StatefulWidget {
  final StudentStore controller;
  final String title;
  StudentPage({
    this.title = 'Alunos',
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

  final _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Observer(
        builder: (context) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              title: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Modular.to.pop();
                      Modular.dispose();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.purple,
                    ),
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.purple.shade900,
                    ),
                  ),
                ],
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
                      scaffoldKey.currentState!.showBottomSheet<void>(
                        (BuildContext context) => AddStudentpage(
                          firstNameController: firstNameController,
                          lastNameController: lastNameController,
                          func: () {
                            controller.createStudent(
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
                            );
                            Navigator.pop(context);
                            lastNameController.clear();
                            firstNameController.clear();
                          },
                        ),
                      );
                    },
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
              child: controller.studentList.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.studentList.length,
                      itemBuilder: (_, index) {
                        final student = controller.studentList[index];
                        return StudentListTile(
                          student: student,
                          firstNameEditController: firstNameEditController,
                          lastNameEditController: lastNameEditController,
                          controller: controller,
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        "Nenhum aluno cadastrado",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
