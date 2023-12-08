mixin class LoginValidator {
  String? validator(String? text) {
    if (text!.isEmpty) {
      return 'O campo não pode ser vazio.';
    }

    if (text.length < 3) {
      return 'O campo deve conter no mínimo 3 caracteres.';
    }

    return null;
  }
}
