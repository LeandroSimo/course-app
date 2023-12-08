import 'package:teste_vrsoft/app/modules/login/presentation/ui/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_vrsoft/app/modules/login/stores/login_store.dart';

class LoginModule extends Module {
  @override
  void binds(Injector i) {
    i.add(LoginStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const LoginPage());
  }
}
