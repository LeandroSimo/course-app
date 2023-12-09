import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:teste_vrsoft/app/modules/student/presentation/ui/add_student_page.dart';
import 'package:teste_vrsoft/app/modules/student/presentation/ui/search_student_page.dart';
import 'package:teste_vrsoft/app/modules/student/presentation/widgets/student_card.dart';
import 'package:teste_vrsoft/app/modules/student/stores/student_store.dart';
import 'package:flutter/material.dart';

class StudenListtPage extends StatefulWidget {
  final StudentStore controller;
  final String title;
  StudenListtPage({
    this.title = 'Alunos',
    required this.controller,
  });

  @override
  StudenListtPageState createState() => StudenListtPageState();
}

class StudenListtPageState extends State<StudenListtPage> {
  StudentStore get controller => widget.controller;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController firstNameEditController = TextEditingController();
  TextEditingController lastNameEditController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final arguments = Modular.args.data;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final bool isAdm = arguments["isAdm"];
    return SafeArea(
      child: Observer(
        builder: (context) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  Modular.to.pushNamedAndRemoveUntil(
                    "/redirect",
                    (_) => false,
                    arguments: arguments,
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.purple,
                ),
              ),
              title: Text(
                widget.title,
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
                        return StudentCard(
                          student: student,
                          firstNameEditController: firstNameEditController,
                          lastNameEditController: lastNameEditController,
                          controller: controller,
                          func: () {
                            Modular.to.navigate("/student/details", arguments: {
                              "student": student,
                              "isAdm": isAdm,
                            });
                          },
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
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                StudentEntity? entity = await showSearch(
                  context: context,
                  delegate: StudentSearchDelegate(controller: controller),
                );
                // print com o valor retorna do showSearch
                print("VALOR DE ENTITY: ${entity!.firstName}");
              },
              child: const Icon(Icons.search),
            ),
          );
        },
      ),
    );
  }
}
