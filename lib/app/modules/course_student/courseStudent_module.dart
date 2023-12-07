import 'package:teste_vrsoft/app/modules/course/course_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/course_student/presentation/ui/course_student_page.dart';

class CourseStudentModule extends Module {
  @override
  List<Module> get imports => [
        CourseModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => CourseStudentPage());
    r.module('/course', module: CourseModule());
  }
}
