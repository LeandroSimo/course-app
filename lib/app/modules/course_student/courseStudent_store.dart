import 'package:mobx/mobx.dart';

part 'courseStudent_store.g.dart';

class CourseStudentStore = _CourseStudentStoreBase with _$CourseStudentStore;
abstract class _CourseStudentStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}