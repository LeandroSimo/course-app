import 'package:objectbox/objectbox.dart';
import 'objectbox.g.dart';

class StudentObjectBox {
  static Store? _store;

  Future<Store> getStore() async {
    return _store ??= await openStore();
  }
}
