import 'package:teste_vrsoft/app/modules/course/course_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/course_student/presentation/ui/course_student_page.dart';
import 'package:teste_vrsoft/app/modules/course_student/stores/course_student_store.dart';

class CourseStudentModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.add(CourseStudentStore.new);
  }

  @override
  List<Module> get imports => [
        CourseModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (_) => CourseStudentPage(
              student: r.args.data,
              courseStore: Modular.get(),
            ));
    r.module('/course', module: CourseModule());
  }
}
