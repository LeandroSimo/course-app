import 'package:teste_vrsoft/app/modules/student/student_page.dart';
import 'package:teste_vrsoft/app/modules/student/student_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StudentModule extends Module {
  // @override
  // void exportedBinds(Injector i) {
  //   i.add(StudentStore.new);
  // }

  @override
  void binds(Injector i) {
    i.add(StudentStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => StudentPage(
        controller: Modular.get(),
      ),
    );
  }
}
