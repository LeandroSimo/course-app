import 'package:teste_vrsoft/app/modules/student/shared/utils/validator_utilis.dart';

mixin class StudentValidator {
  String? firstNameValidate(String? text) {
    if (text!.isEmpty) {
      return 'O nome do aluno não pode ser vazio.';
    }

    if (text.length < 3) {
      return 'O nome do aluno deve conter no mínimo 3 caracteres.';
    }

    if (text.isValidStudent() == false) {
      return 'O nome do aluno não pode conter caracteres especiais.';
    }

    return null;
  }

  String? lastNameValidate(String? text) {
    if (text!.isEmpty) {
      return 'O sobrenome do aluno não pode ser vazio.';
    }

    if (text.length < 3) {
      return 'O sobrenome do aluno deve conter no mínimo 3 caracteres.';
    }

    if (text.isValidStudent() == false) {
      return 'O sobrenome do aluno não pode conter caracteres especiais.';
    }

    return null;
  }
}
