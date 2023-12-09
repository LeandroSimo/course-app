import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:teste_vrsoft/app/modules/student/presentation/ui/student_details_page.dart';
import 'package:teste_vrsoft/app/modules/student/presentation/ui/student_list_page.dart';
import 'package:teste_vrsoft/app/modules/student/stores/student_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StudentModule extends Module {
  @override
  void binds(Injector i) {
    i.add(StudentStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => StudenListtPage(controller: Modular.get()));
    r.child(
      '/details',
      child: (_) => StudentDetailsPage(
        studentStore: Modular.get(),
        student: r.args.data,
      ),
    );
  }
}
