import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:teste_vrsoft/app/modules/login/presentation/widgets/card_adm.dart';

class RedirectAdminRegister extends StatefulWidget {
  const RedirectAdminRegister({super.key});

  @override
  State<RedirectAdminRegister> createState() => _RedirectAdminRegisterState();
}

class _RedirectAdminRegisterState extends State<RedirectAdminRegister> {
  final arguments = Modular.args.data;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 2,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Modular.to.pushNamedAndRemoveUntil(
                Modular.initialRoute,
                (_) => false,
              );
            },
            icon: const Icon(
              Icons.login_outlined,
              color: Colors.purple,
            ),
          ),
          title: Text(
            "Área do Administrador",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.purple.shade900,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          width: _size.width,
          child: ListView(
            children: [
              const Gap(50),
              CardAdm(
                size: _size,
                title: 'Curso',
                onTap: () => Modular.to.navigate(
                  "/course/",
                  arguments: arguments,
                ),
                srcImg:
                    "https://plus.unsplash.com/premium_photo-1679079456083-9f288e224e96?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              ),
              const Gap(20),
              CardAdm(
                size: _size,
                title: 'Aluno',
                onTap: () => Modular.to.navigate(
                  "/student/",
                  arguments: arguments,
                ),
                srcImg:
                    "https://images.unsplash.com/photo-1523580846011-d3a5bc25702b?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
