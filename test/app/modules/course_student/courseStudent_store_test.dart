import 'package:flutter_test/flutter_test.dart';
import 'package:teste_vrsoft/app/modules/course_student/courseStudent_store.dart';
 
void main() {
  late CourseStudentStore store;

  setUpAll(() {
    store = CourseStudentStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}