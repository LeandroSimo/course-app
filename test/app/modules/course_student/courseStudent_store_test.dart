import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teste_vrsoft/app/database/objectbox.g.dart';
import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';

void main() async {
  late Store _store;

  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel('plugins.flutter.io/path_provider')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    return 'test/app/modules';
  });

  await getApplicationDocumentsDirectory();

  setUpAll(() async {
    _store = await openStore();
  });

  // Função para adicionar um aluno a um curso
  bool addStudentToCourse(StudentEntity student, CourseEntity course) {
    if (!course.isFullClass() &&
        !course.students.contains(student) &&
        !student.exceededLimit()) {
      course.students.add(student);
      student.saveToCourseStudentTable(course);
      return true;
    }
    return false;
  }

// Função para adicionar um curso a um aluno
  bool addCourseToStudent(CourseEntity course, StudentEntity student) {
    if (!student.exceededLimit() &&
        !student.courses.contains(course) &&
        !course.isFullClass()) {
      student.courses.add(course);
      course.saveToCourseStudentTable(student);
      return true;
    }
    return false;
  }

  // Criar instâncias de StudentEntity, CourseEntity e CourseStudentEntity
  StudentEntity student = StudentEntity(firstName: "John", lastName: "Doe");
  CourseEntity course = CourseEntity(
    name: "Computer Science",
    description: "Introduction to Programming",
    schedule: "Monday, Wednesday, Friday",
    level: "Beginner",
  );

  test("Adicionando aluno ao curso", () {
    // Adicionar aluno ao curso
    if (addStudentToCourse(student, course)) {
      print("Aluno adicionado ao curso com sucesso!");
    } else {
      print("Não foi possível adicionar o aluno ao curso.");
    }
    // expect(addStudentToCourse(student, course), false);
  });

  test("Adicionando curso ao aluno", () {
    // Adicionar curso ao aluno
    if (addCourseToStudent(course, student)) {
      print("Curso adicionado ao aluno com sucesso!");
    } else {
      print("Não foi possível adicionar o curso ao aluno.");
    }
    // expect(addCourseToStudent(course, student), false);
  });

  test("Testando adição por IDs", () {
    //Teste 2

    // Função para adicionar um aluno a um curso usando IDs
    bool addStudentToCourseById(int studentId, int courseId) {
      final student = _store.box<StudentEntity>().get(studentId);
      final course = _store.box<CourseEntity>().get(courseId);

      if (student != null && course != null) {
        return addStudentToCourse(student, course);
      }
      return false;
    }

// Função para adicionar um curso a um aluno usando IDs
    bool addCourseToStudentById(int courseId, int studentId) {
      final course = _store.box<CourseEntity>().get(courseId);
      final student = _store.box<StudentEntity>().get(studentId);

      if (course != null && student != null) {
        return addCourseToStudent(course, student);
      }
      return false;
    }

// Supondo que você tenha os IDs dos alunos e cursos
    int studentId = 1;
    int courseId = 2;

// Adicionar aluno ao curso usando IDs
    if (addStudentToCourseById(studentId, courseId)) {
      print("Aluno adicionado ao curso com sucesso!");
    } else {
      print("Não foi possível adicionar o aluno ao curso.");
    }

// Adicionar curso ao aluno usando IDs
    if (addCourseToStudentById(courseId, studentId)) {
      print("Curso adicionado ao aluno com sucesso!");
    } else {
      print("Não foi possível adicionar o curso ao aluno.");
    }
  });
}

// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:objectbox/objectbox.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:teste_vrsoft/app/database/objectbox.g.dart';
// import 'package:teste_vrsoft/app/database/student_objectbox.dart';
// import 'package:teste_vrsoft/app/modules/course/entities/course_entity.dart';
// import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';

// void main() async {
//   late Store _store;

//   TestWidgetsFlutterBinding.ensureInitialized();

//   const MethodChannel('plugins.flutter.io/path_provider')
//       .setMockMethodCallHandler((MethodCall methodCall) async {
//     return 'test/app/modules';
//   });

//   await getApplicationDocumentsDirectory();

//   setUpAll(() async {
//     _store = await openStore();
//   });

//   bool addStudentToCourse(StudentEntity student, CourseEntity course) {
//     if (!course.isFullClass() &&
//         !course.students.contains(student) &&
//         !student.exceededLimit()) {
//       course.students.add(student);
//       student.saveToCourseStudentTable(course);
//       return true;
//     }
//     return false;
//   }

// // Função para adicionar um curso a um aluno
//   bool addCourseToStudent(CourseEntity course, StudentEntity student) {
//     if (!student.exceededLimit() &&
//         !student.courses.contains(course) &&
//         !course.isFullClass()) {
//       student.courses.add(course);
//       course.saveToCourseStudentTable(student);
//       return true;
//     }
//     return false;
//   }

// // Função para adicionar um curso a um aluno usando IDs
//   bool addCourseToStudentById(int courseId, int studentId) {
//     final course = _store.box<CourseEntity>().get(courseId);
//     final student = _store.box<StudentEntity>().get(studentId);

//     if (course != null && student != null) {
//       return addCourseToStudent(course, student);
//     }
//     return false;
//   }

//   test('Teste de adição de aluno a curso por ID', () {
//     // Supondo que você tenha os IDs dos alunos e cursos
//     int studentId = 1;
//     int courseId = 2;

//     bool addStudentToCourse(StudentEntity student, CourseEntity course) {
//       if (!course.isFullClass() &&
//           !course.students.contains(student) &&
//           !student.exceededLimit()) {
//         course.students.add(student);
//         student.saveToCourseStudentTable(course);
//         return true;
//       } else {
//         print("Falha ao adicionar aluno ao curso. Detalhes:");
//         if (course.isFullClass()) print("Curso está cheio.");
//         if (course.students.contains(student)) print("Aluno já está no curso.");
//         if (student.exceededLimit()) print("Aluno excedeu o limite de cursos.");
//       }
//       return false;
//     }

//     bool addCourseToStudent(CourseEntity course, StudentEntity student) {
//       if (!student.exceededLimit() &&
//           !student.courses.contains(course) &&
//           !course.isFullClass()) {
//         student.courses.add(course);
//         course.saveToCourseStudentTable(student);
//         return true;
//       } else {
//         print("Falha ao adicionar curso ao aluno. Detalhes:");
//         if (student.exceededLimit()) print("Aluno excedeu o limite de cursos.");
//         if (student.courses.contains(course)) print("Aluno já está no curso.");
//         if (course.isFullClass()) print("Curso está cheio.");
//       }
//       return false;
//     }

//     // Função para adicionar um aluno a um curso usando IDs
//     bool addStudentToCourseById(int studentId, int courseId) {
//       final student = _store.box<StudentEntity>().get(studentId);
//       final course = _store.box<CourseEntity>().get(courseId);

//       if (student != null && course != null) {
//         return addStudentToCourse(student, course);
//       }
//       return false;
//     }

// // Função para adicionar um curso a um aluno usando IDs
//     bool addCourseToStudentById(int courseId, int studentId) {
//       final course = _store.box<CourseEntity>().get(courseId);
//       final student = _store.box<StudentEntity>().get(studentId);

//       if (course != null && student != null) {
//         return addCourseToStudent(course, student);
//       }
//       return false;
//     }

//     // Adicionar aluno ao curso usando IDs
//     if (addStudentToCourseById(studentId, courseId)) {
//       print("Aluno adicionado ao curso com sucesso!");
//     } else {
//       print("Não foi possível adicionar o aluno ao curso.");
//     }

//     // Adicionar curso ao aluno usando IDs
//     if (addCourseToStudentById(courseId, studentId)) {
//       print("Curso adicionado ao aluno com sucesso!");
//     } else {
//       print("Não foi possível adicionar o curso ao aluno.");
//     }
//   });
// }
