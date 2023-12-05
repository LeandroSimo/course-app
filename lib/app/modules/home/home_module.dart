import 'package:flutter_modular/flutter_modular.dart';
import 'home_store.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.add(HomeStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => HomePage());
  }
}
