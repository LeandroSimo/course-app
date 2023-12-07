import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/course/stores/course_store.dart';

class MockCourseStore extends Mock implements CourseStore {}

void main() {
  late MockCourseStore store;

  setUpAll(() {
    store = MockCourseStore();
  });

  test('Testing the getAllCourse method', () async {
    when(() => store.getAllCourse()).thenAnswer((_) async => []);
    expect(await store.getAllCourse(), isA<List>());
  });

  test('Testing the createCourse method', () async {
    final course = CourseEntity(
        name: "Java Script",
        description: "Curso de Java Script",
        schedule: "Segunda a Sexta",
        courseBackGroundColor: "#000000");
    when(() => store.createCourse(course)).thenAnswer((_) async => 1);
    expect(await store.createCourse(course), isA<int>());
  });

  test('Testing the updateCourse method', () async {
    final course = CourseEntity(
        name: "Java Script",
        description: "Curso de Java Script",
        schedule: "Segunda a Sexta",
        courseBackGroundColor: "#000000");
    when(() => store.updateCourse(course)).thenAnswer((_) async => 1);
    expect(await store.updateCourse(course), isA<int>());
  });

  test('Testing the removeCourse method', () async {
    final course = CourseEntity(
        name: "Java Script",
        description: "Curso de Java Script",
        schedule: "Segunda a Sexta",
        courseBackGroundColor: "#000000");
    store.removeCourse(course);
  });
}
