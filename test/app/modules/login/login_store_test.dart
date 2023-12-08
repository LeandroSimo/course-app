import 'package:flutter_test/flutter_test.dart';
import 'package:teste_vrsoft/app/modules/login/stores/login_store.dart';

void main() {
  late LoginStore store;

  setUpAll(() {
    store = LoginStore();
  });
}
