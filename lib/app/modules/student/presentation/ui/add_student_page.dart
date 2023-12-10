import 'package:flutter/material.dart';
import 'package:teste_vrsoft/app/modules/student/shared/validator/validator.dart';

class AddStudentpage extends StatefulWidget {
  final Function() func;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  const AddStudentpage(
      {super.key,
      required this.func,
      required this.firstNameController,
      required this.lastNameController});

  @override
  State<AddStudentpage> createState() => _AddStudentpageState();
}

class _AddStudentpageState extends State<AddStudentpage> with StudentValidator {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Container(
        height: size.height * 0.5,
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Novo Aluno',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      controller: widget.firstNameController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Nome',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      validator: (value) => firstNameValidate(value),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: widget.lastNameController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Sobrenome',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      validator: (value) => lastNameValidate(value),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_form.currentState!.validate()) {
                      widget.func();
                    }
                  },
                  child: Text(
                    'Adicionar Aluno',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
