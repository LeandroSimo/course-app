import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:teste_vrsoft/app/modules/login/shared/validator/login_validator.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:teste_vrsoft/app/modules/student/stores/student_store.dart';

class LoginPage extends StatefulWidget {
  final StudentStore studentStore;
  const LoginPage({
    super.key,
    required this.studentStore,
  });
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with LoginValidator {
  StudentStore get studentStore => widget.studentStore;

  bool isAdm = false;
  bool isRegistered = true;

  final form = GlobalKey<FormState>();

  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  final TextEditingController _controllerFirstNameRegister = TextEditingController();
  final TextEditingController _controllerLastNameRegister = TextEditingController();

  loginAndRegister() {
    if (form.currentState!.validate()) {
      final student = StudentEntity(
        firstName: _controllerFirstNameRegister.text,
        lastName: _controllerLastNameRegister.text,
      );

      if (isAdm) {
        if (_controllerUser.text == "admin" &&
            _controllerPassword.text == "admin") {
          Modular.to.navigate('/redirect', arguments: {
            "isAdm": isAdm,
          });
          clearTextEditingControllers();
        }
      }

      if (!isRegistered) {
        studentStore.createStudent(student);
        Modular.to.pushNamedAndRemoveUntil(
          '/home/',
          (_) => false,
          arguments: student,
        );
        clearTextEditingControllers();
      } else {
        final isStudent = studentStore.studentList
            .any((student) => student.firstName == _controllerUser.text);

        if (isStudent) {
          Modular.to.pushNamedAndRemoveUntil(
            '/home/',
            (_) => false,
            arguments: studentStore.studentList.firstWhere(
                (student) => student.firstName == _controllerUser.text),
          );
          clearTextEditingControllers();
        }
      }
    }
  }

  clearTextEditingControllers() {
    _controllerUser.clear();
    _controllerPassword.clear();
    _controllerFirstNameRegister.clear();
    _controllerLastNameRegister.clear();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.purple.shade900,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                height: size.height * 0.5,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        isRegistered
                            ? const SizedBox(height: 20)
                            : const SizedBox(
                                height: 5,
                              ),
                        Text(
                          !isRegistered ? 'Cadastrar' : 'Entrar',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        isRegistered
                            ? const SizedBox()
                            : const SizedBox(height: 10),
                        isAdm
                            ? const SizedBox(height: 20)
                            : !isRegistered
                                ? const SizedBox()
                                : const Gap(50),
                        isRegistered
                            ? TextFormField(
                                validator: validator,
                                controller: _controllerUser,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText:
                                      isAdm ? 'Administrador' : 'Usuário',
                                ),
                              )
                            : TextFormField(
                                validator: validator,
                                controller: _controllerFirstNameRegister,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Nome",
                                ),
                              ),
                        const SizedBox(height: 20),
                        isAdm
                            ? TextFormField(
                                validator: validator,
                                controller: _controllerPassword,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Senha',
                                ),
                              )
                            : !isRegistered
                                ? TextFormField(
                                    validator: validator,
                                    controller: _controllerLastNameRegister,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Sobrenome',
                                    ),
                                  )
                                : const SizedBox(),
                        const SizedBox(height: 30),
                        SizedBox(
                          height: size.height * 0.08,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple.shade900,
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            onPressed: loginAndRegister,
                            child: Text(
                              isRegistered ? 'Entra' : 'Cadastrar',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        !isAdm
                            ? TextButton(
                                child: Text(
                                  isRegistered
                                      ? 'Cadastre-se'
                                      : "Já tenho conta",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.purple.shade900,
                                  ),
                                ),
                                onPressed: () => setState(
                                    () => isRegistered = !isRegistered),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: !isRegistered
                      ? null
                      : () {
                          setState(() => isAdm = !isAdm);
                          clearTextEditingControllers();
                        },
                  child: Text(
                    !isAdm
                        ? 'Entrar como administrador'
                        : 'Entrar como usuário',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: isRegistered ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
