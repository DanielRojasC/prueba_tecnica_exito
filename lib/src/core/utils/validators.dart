class Validators {
  static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static String? isNotEmpty(String value) => _required(value);

  static String? isEmail(String email) {
    final requiredError = _required(email);
    if (requiredError != null) {
      return requiredError;
    }

    if (!_emailRegex.hasMatch(email)) {
      return "Ingrese un correo válido";
    }

    return null;
  }

  static String? isPassword(String password) {
    final requiredError = _required(password);
    if (requiredError != null) {
      return requiredError;
    }

    if (password.length < 6) {
      return "La contraseña no es válida";
    }

    return null;
  }

  static String? hasMatchPassword(String password, String confirmPassword) {
    final requiredError = _required(confirmPassword);
    if (requiredError != null) {
      return requiredError;
    }

    if (password != confirmPassword) {
      return "Las contraseñas no coinciden";
    }

    return null;
  }

  static String? _required(String value) =>
      value.isEmpty ? "El campo es obligatorio" : null;
}
