// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CourseStore on _CourseStoreBase, Store {
  late final _$courseListAtom =
      Atom(name: '_CourseStoreBase.courseList', context: context);

  @override
  List<CourseEntity> get courseList {
    _$courseListAtom.reportRead();
    return super.courseList;
  }

  @override
  set courseList(List<CourseEntity> value) {
    _$courseListAtom.reportWrite(value, super.courseList, () {
      super.courseList = value;
    });
  }

  late final _$getAllCourseAsyncAction =
      AsyncAction('_CourseStoreBase.getAllCourse', context: context);

  @override
  Future<List<CourseEntity>> getAllCourse() {
    return _$getAllCourseAsyncAction.run(() => super.getAllCourse());
  }

  late final _$createCourseAsyncAction =
      AsyncAction('_CourseStoreBase.createCourse', context: context);

  @override
  Future<int> createCourse(CourseEntity course) {
    return _$createCourseAsyncAction.run(() => super.createCourse(course));
  }

  late final _$updateCourseAsyncAction =
      AsyncAction('_CourseStoreBase.updateCourse', context: context);

  @override
  Future<int> updateCourse(CourseEntity course) {
    return _$updateCourseAsyncAction.run(() => super.updateCourse(course));
  }

  late final _$addStudentToCourseAsyncAction =
      AsyncAction('_CourseStoreBase.addStudentToCourse', context: context);

  @override
  Future<int> addStudentToCourse(CourseEntity course, StudentEntity student) {
    return _$addStudentToCourseAsyncAction
        .run(() => super.addStudentToCourse(course, student));
  }

  late final _$addStudentToCoursesAsyncAction =
      AsyncAction('_CourseStoreBase.addStudentToCourses', context: context);

  @override
  Future<int> addStudentToCourses(
      List<CourseEntity> courses, StudentEntity student) {
    return _$addStudentToCoursesAsyncAction
        .run(() => super.addStudentToCourses(courses, student));
  }

  late final _$_CourseStoreBaseActionController =
      ActionController(name: '_CourseStoreBase', context: context);

  @override
  void removeCourse(CourseEntity course) {
    final _$actionInfo = _$_CourseStoreBaseActionController.startAction(
        name: '_CourseStoreBase.removeCourse');
    try {
      return super.removeCourse(course);
    } finally {
      _$_CourseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
courseList: ${courseList}
    ''';
  }
}
