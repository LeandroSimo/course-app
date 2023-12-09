import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/course/presentation/ui/add_course_page.dart';
import 'package:teste_vrsoft/app/modules/course/presentation/ui/course_details.dart';
import 'package:teste_vrsoft/app/modules/course/presentation/ui/course_list_page.dart';
import 'package:teste_vrsoft/app/modules/course/stores/course_store.dart';

class CourseModule extends Module {
  @override
  void binds(Injector i) {
    i.add(CourseStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => CourseListPage(
        courseStore: Modular.get(),
        studentStore: Modular.get(),
      ),
    );
    r.child('/add', child: (_) => AddCoursePage(courseStore: Modular.get()));
    r.child('/details',
        child: (_) => CourseDetails(studentStore: Modular.get()));
  }
}
