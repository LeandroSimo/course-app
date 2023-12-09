import 'package:objectbox/objectbox.dart';
import 'package:teste_vrsoft/app/database/entities/couse_student_entity.dart';
import 'package:teste_vrsoft/app/database/objectbox.g.dart';
import 'package:teste_vrsoft/app/database/student_objectbox.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';

class CourseStudentRepository {
  late CourseStudentObjectBox _studentObjectBox;

  CourseStudentRepository() {
    _studentObjectBox = CourseStudentObjectBox();
  }

  Future<Box> getCourseAndStudent() async {
    final store = await _studentObjectBox.getStore();
    return store.box<CourseStudentEntity>();
  }

  Future<List<CourseStudentEntity>> getAllCourseStudents() async {
    final box = await getCourseAndStudent();
    return box.getAll() as List<CourseStudentEntity>;
  }

  Future<int> createCourseStudent(
      StudentEntity student, CourseEntity course) async {
    final box = await getCourseAndStudent();

    // Criando uma instâncias de ToOne para associar com CourseStudentEntity
    final studentToOne = ToOne<StudentEntity>()..target = student;
    final courseToOne = ToOne<CourseEntity>()..target = course;

    final courseStudent = CourseStudentEntity(
      student: studentToOne,
      course: courseToOne,
    );
    return box.put(courseStudent);
  }

  Future<CourseStudentEntity?> getCourseStudentById(int id) async {
    final box = await getCourseAndStudent();
    return box.get(id);
  }
}
