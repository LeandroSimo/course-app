import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/course_student/courseStudent_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CourseStudentModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.module('/', module: CourseStudentModule());
  }
}
