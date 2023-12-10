// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StudentStore on _StudentStoreBase, Store {
  late final _$getAllStudentAsyncAction =
      AsyncAction('_StudentStoreBase.getAllStudent', context: context);

  @override
  Future<List<StudentEntity>> getAllStudent() {
    return _$getAllStudentAsyncAction.run(() => super.getAllStudent());
  }

  late final _$createStudentAsyncAction =
      AsyncAction('_StudentStoreBase.createStudent', context: context);

  @override
  Future<int> createStudent(StudentEntity student) {
    return _$createStudentAsyncAction.run(() => super.createStudent(student));
  }

  late final _$updateStudentAsyncAction =
      AsyncAction('_StudentStoreBase.updateStudent', context: context);

  @override
  Future<int> updateStudent(StudentEntity student) {
    return _$updateStudentAsyncAction.run(() => super.updateStudent(student));
  }

  late final _$addCourseToStudentAsyncAction =
      AsyncAction('_StudentStoreBase.addCourseToStudent', context: context);

  @override
  Future<int> addCourseToStudent(StudentEntity student, CourseEntity course) {
    return _$addCourseToStudentAsyncAction
        .run(() => super.addCourseToStudent(student, course));
  }

  late final _$_StudentStoreBaseActionController =
      ActionController(name: '_StudentStoreBase', context: context);

  @override
  void removeStudent(StudentEntity student) {
    final _$actionInfo = _$_StudentStoreBaseActionController.startAction(
        name: '_StudentStoreBase.removeStudent');
    try {
      return super.removeStudent(student);
    } finally {
      _$_StudentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
