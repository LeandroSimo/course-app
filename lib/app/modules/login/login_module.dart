import 'package:teste_vrsoft/app/modules/login/presentation/ui/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/login/presentation/ui/redirect_admin_register.dart';
import 'package:teste_vrsoft/app/modules/login/stores/login_store.dart';
import 'package:teste_vrsoft/app/modules/student/stores/student_store.dart';

class LoginModule extends Module {
  @override
  void binds(Injector i) {
    i.add(LoginStore.new);
    i.addLazySingleton(StudentStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (_) => LoginPage(studentStore: Modular.get<StudentStore>()));
    r.child('/redirect', child: (_) => const RedirectAdminRegister());
  }
}
