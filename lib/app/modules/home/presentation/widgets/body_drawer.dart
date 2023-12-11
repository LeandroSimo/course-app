import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';

class BodyDrawer extends StatelessWidget {
  final StudentEntity student;

  const BodyDrawer({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.purple.shade900,
          ),
          child: Center(
            child: CircleAvatar(
              radius: 50,
              child: Text(
                _checkName(student.firstName),
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
        ListTile(
          title: const Row(
            children: [
              Icon(Icons.person_outline),
              Text(
                "Perfil",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          onTap: () {
            Modular.to.navigate(
              '/student/',
              arguments: {
                "student": student,
                "isAdm": false,
              },
            );
          },
        ),
        ListTile(
          title: const Row(
            children: [
              Icon(Icons.class_outlined),
              Text(
                "Cursos",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          onTap: () {
            Modular.to.navigate(
              '/course/',
              arguments: {
                "student": student,
                "isAdm": false,
              },
            );
          },
        ),
        const Spacer(),
        ListTile(
          title: const Row(
            children: [
              Icon(Icons.exit_to_app),
              Text(
                "Sair",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          onTap: () {
            Modular.to.pushReplacementNamed(Modular.initialRoute);
          },
        ),
      ],
    );
  }

  String _checkName(String originalName) {
    if (originalName.contains(' ')) {
      final parts = originalName.split(' ');
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}';
      }
    }
    if (originalName.length > 4) {
      return originalName.substring(0, 2).toUpperCase();
    }
    return originalName.toUpperCase();
  }
}
