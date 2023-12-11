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

  final TextEditingController _controllerFirstNameRegister =
      TextEditingController();
  final TextEditingController _controllerLastNameRegister =
      TextEditingController();

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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/course.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/course.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'DevAPP',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Gap(10),
                      Text(
                        'Cursos',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: SingleChildScrollView(
                  child: Form(
                    key: form,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Gap(30),
                        isRegistered
                            ? const SizedBox(height: 20)
                            : const SizedBox(
                                height: 5,
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              !isRegistered ? 'Cadastrar' : 'Entrar',
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
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
                        Gap(10),
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
                                  color: isRegistered
                                      ? Colors.purple.shade900
                                      : Colors.grey,
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
            ),
          ],
        ),
      ),
    );
  }
}
