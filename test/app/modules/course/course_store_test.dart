import 'package:flutter_test/flutter_test.dart';
import 'package:teste_vrsoft/app/modules/course/course_store.dart';
 
void main() {
  late CourseStore store;

  setUpAll(() {
    store = CourseStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}