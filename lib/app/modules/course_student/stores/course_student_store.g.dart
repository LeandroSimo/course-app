// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_student_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CourseStudentStore on _CourseStudentStoreBase, Store {
  late final _$getAllCourseStudentsAsyncAction = AsyncAction(
      '_CourseStudentStoreBase.getAllCourseStudents',
      context: context);

  @override
  Future<List<CourseStudentEntity>> getAllCourseStudents() {
    return _$getAllCourseStudentsAsyncAction
        .run(() => super.getAllCourseStudents());
  }

  late final _$createCourseStudentAsyncAction = AsyncAction(
      '_CourseStudentStoreBase.createCourseStudent',
      context: context);

  @override
  Future<int> createCourseStudent(StudentEntity student, CourseEntity course) {
    return _$createCourseStudentAsyncAction
        .run(() => super.createCourseStudent(student, course));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
