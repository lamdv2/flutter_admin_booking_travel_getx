class Regex {
  static bool isEmail(String email) {
    RegExp regExp = RegExp(r'\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*');
    return regExp.hasMatch(email);
  }

  static bool isPassword(String password) {
    RegExp regExp = RegExp(r'^.{6,}$');
    return regExp.hasMatch(password);
  }

  static bool isStrongPassword(String password) {
    if (password.length < 6) {
      return false;
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false;
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return false;
    }
    if (!password.contains(RegExp(r'[@#$%^&+=]'))) {
      return false;
    }
    return true;
  }

  static bool isPasswordUpcase(String password) {
    return password.contains(RegExp(r'[A-Z]'));
  }

  static bool isPasswordNumber(String password) {
    return password.contains(RegExp(r'[0-9]'));
  }

  static bool isPasswordSpecialChar(String password) {
    return password.contains(RegExp(r'[!@#$%^&+=]'));
  }

  static RegExp regExpYoutube = RegExp(
    r'^(http(s)?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.+',
    caseSensitive: false,
  );

  static bool isPasswordAtLeast6Characters(String password) {
    return password.length >= 6;
  }

  static bool isPhoneNumber(String username) {
    RegExp regExp = RegExp(r'^.{9,}$');
    return regExp.hasMatch(username);
  }

  static bool isNumericOnly(String input) {
    if (input.isEmpty) {
      return false;
    }
    return double.tryParse(input) != null || int.tryParse(input) != null;
  }

  static bool containsAtSign(String input) {
    return input.contains('@');
  }
}
