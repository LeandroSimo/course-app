import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/course/course_module.dart';
import 'package:teste_vrsoft/app/modules/home/home_module.dart';
import 'package:teste_vrsoft/app/modules/login/login_module.dart';
import 'package:teste_vrsoft/app/modules/student/student_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        LoginModule(),
        HomeModule(),
        CourseModule(),
        StudentModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.module('/', module: LoginModule());
    r.module('/home', module: HomeModule());
    r.module('/course', module: CourseModule());
    r.module('/student', module: StudentModule());
  }
}
