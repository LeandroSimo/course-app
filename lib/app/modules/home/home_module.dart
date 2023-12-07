import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/course/course_module.dart';
import 'package:teste_vrsoft/app/modules/home/stores/home_store.dart';
import 'package:teste_vrsoft/app/modules/student/student_module.dart';

import 'presentation/ui/home_page.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
        StudentModule(),
        CourseModule(),
      ];

  @override
  void binds(Injector i) {
    i.add(HomeStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const HomePage());
    r.module('/student', module: StudentModule());
    r.module('/course', module: CourseModule());
  }
}
