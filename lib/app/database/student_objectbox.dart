import 'package:objectbox/objectbox.dart';
import 'objectbox.g.dart';

class StudentObjectBox {
  Store? _store;

  Future<Store> getStore() async {
    return _store ??= await openStore();
  }
}
