

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'E-mail address is required.';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty)
    return 'Password is required.';

  return null;
}

String? validatePassword1(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password is required.';
  }

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword)) {
    return '''
    Password must be at least 8 characters,
    include an uppercase letter, number and symbol.
    ''';
  }

  return null;
}

String? validateFullName(String? formFullName) {
  if (formFullName == null || formFullName.isEmpty) {
    return 'Full Name is required.';
  }

  return null;
}

String? validatePhoneNumber(String? formPhoneNumber) {
  if (formPhoneNumber == null || formPhoneNumber.isEmpty) {
    return 'Phone Number is required.';
  }

  return null;
}


