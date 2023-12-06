extension Emailvalidator on String {
  bool isValidStudent() {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);
  }
}
