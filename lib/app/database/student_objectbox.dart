import 'objectbox.g.dart';

class CourseStudentObjectBox {
  static Store? _store;

  Future<Store> getStore() async {
    return _store ??= await openStore();
  }
}
