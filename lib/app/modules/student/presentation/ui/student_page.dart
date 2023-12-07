import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:teste_vrsoft/app/modules/student/presentation/ui/add_student_page.dart';
import 'package:teste_vrsoft/app/modules/student/presentation/ui/search_student_page.dart';
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
                              func: _showAlertDialog(context, _size),
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
                          func: () {
                            Modular.to.navigate(
                              "/student/details",
                              arguments: student,
                            );
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
                // print para com o valor retorna do showSearch
                print("VALOR DE ENTITY: ${entity!.firstName}");
              },
              child: const Icon(Icons.search),
            ),
          );
        },
      ),
    );
  }

  _showAlertDialog(BuildContext context, Size size) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: 40,
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
                const Spacer(),
                const Text(
                  'Aluno já cadastrado!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
