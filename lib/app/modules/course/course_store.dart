import 'package:mobx/mobx.dart';

part 'course_store.g.dart';

class CourseStore = _CourseStoreBase with _$CourseStore;
abstract class _CourseStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}