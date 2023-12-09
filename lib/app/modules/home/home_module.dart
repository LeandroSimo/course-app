import 'package:teste_vrsoft/app/modules/course/course_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/home/presentation/ui/course_student_page.dart';
import 'package:teste_vrsoft/app/modules/home/stores/home_store.dart';

class HomeModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.add(HomeStore.new);
  }

  @override
  List<Module> get imports => [
        CourseModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (_) => HomePage(
              student: r.args.data,
              courseStore: Modular.get(),
            ));
    r.module('/course', module: CourseModule());
  }
}
