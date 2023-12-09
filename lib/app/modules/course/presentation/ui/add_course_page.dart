import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/course/stores/course_store.dart';

class AddCoursePage extends StatefulWidget {
  final CourseStore courseStore;
  const AddCoursePage({super.key, required this.courseStore});

  @override
  State<AddCoursePage> createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  CourseStore get _courseStore => widget.courseStore;

  final form = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController hoursController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Modular.to.pushNamedAndRemoveUntil(
                "/course/",
                (_) => false,
                arguments: {"isAdm": true},
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.purple,
            ),
          ),
          title: Text(
            'Novo Curso',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.purple.shade900,
            ),
          ),
        ),
        body: Container(
          height: _size.height,
          padding: const EdgeInsets.all(10),
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Observer(builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: nameController,
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
                      // validator: (value) => firstNameValidate(value),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: descriptionController,
                      maxLength: 300,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Descrição',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      // validator: (value) => firstNameValidate(value),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: scheduleController,
                      maxLength: 100,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Ementa',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      // validator: (value) => firstNameValidate(value),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: hoursController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Carga horária',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      // validator: (value) => firstNameValidate(value),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: levelController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Nível do curso',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      // validator: (value) => firstNameValidate(value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                        height: _size.height * 0.08,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.primary),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          onPressed: () {
                            _courseStore.createCourse(
                              CourseEntity(
                                name: nameController.text,
                                description: descriptionController.text,
                                schedule: scheduleController.text,
                                level: levelController.text,
                                hours: hoursController.text,
                              ),
                            );
                            Modular.to.pushNamedAndRemoveUntil(
                              '/course/',
                              (_) => false,
                              arguments: {"isAdm": true},
                            );
                            // if (form.currentState!.validate()) {
                            // }
                          },
                          child: Text(
                            'Adicionar curso',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
