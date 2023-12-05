import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/home/home_page.dart';
import 'package:teste_vrsoft/app/modules/home/home_store.dart';
import 'package:teste_vrsoft/app/modules/student/student_module.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        // HomeModule(),
        StudentModule(),
      ];

  @override
  void routes(RouteManager r) {
    // r.module('/', module: HomeModule());
    r.module('/', module: StudentModule());
  }
}
