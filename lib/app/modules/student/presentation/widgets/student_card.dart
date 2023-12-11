import 'package:flutter/material.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:teste_vrsoft/app/modules/student/stores/student_store.dart';

class StudentCard extends StatelessWidget {
  StudentCard({
    super.key,
    required this.student,
    required this.firstNameEditController,
    required this.lastNameEditController,
    required this.controller,
    required this.func,
    this.isAdm = false,
  });

  final StudentEntity student;
  final TextEditingController firstNameEditController;
  final TextEditingController lastNameEditController;
  final StudentStore controller;
  final Function() func;
  bool isAdm;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: func,
      child: Card(
        elevation: 5,
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            child: Text(
              "${student.firstName[0].substring(0).toUpperCase()}${student.lastName[0].substring(0).toUpperCase()}",
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
                  firstNameEditController.value = TextEditingValue(
                    text: student.firstName,
                  );
                  lastNameEditController.value =
                      TextEditingValue(text: student.lastName);
                  _showAlertDialog(context, size);
                },
              ),
              isAdm
                  ? IconButton(
                      onPressed: () {
                        controller.removeStudent(student);
                      },
                      icon: const Icon(Icons.delete),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  _showAlertDialog(BuildContext context, Size size) {
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
                    Navigator.pop(context);
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
