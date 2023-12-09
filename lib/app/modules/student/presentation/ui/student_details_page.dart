import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';

class StudentDetailsPage extends StatefulWidget {
  const StudentDetailsPage({
    super.key,
  });

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  final arguments = Modular.args.data;
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    final bool isAdm = arguments["isAdm"];
    final StudentEntity student = arguments["student"];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Modular.to.pushNamedAndRemoveUntil(
                '/student',
                (_) => false,
                arguments: {"isAdm": isAdm},
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.purple,
            ),
          ),
          title: Text(
            "Conta",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.purple.shade900,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: Colors.purple,
              ),
            ),
          ],
        ),
        body: SizedBox(
          width: _size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Text(
                    _checkName(student.firstName),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const Gap(20),
                Text(
                  "${student.firstName} ${student.lastName}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.purple.shade900,
                  ),
                ),
                const Gap(20),
                Divider(
                  color: Colors.grey.shade400,
                  thickness: 1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Cursos matriculados",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.purple.shade900,
                        ),
                      ),
                    ),
                    const Gap(20),
                    Container(
                      height: student.courses.isNotEmpty
                          ? _size.height
                          : _size.height * 0.3,
                      width: _size.width,
                      padding: const EdgeInsets.all(10),
                      color: Colors.grey.shade200,
                      child: student.courses.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: student.courses.length,
                              itemBuilder: (context, index) {
                                final course = student.courses[index];
                                return ListTile(
                                  title: Text(
                                    course.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.purple.shade900,
                                    ),
                                  ),
                                  subtitle: Text(
                                    course.description,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.purple.shade900,
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                "Nenhum curso cadastrado",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.purple.shade900,
                                ),
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
