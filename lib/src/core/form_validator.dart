class FormValidator {
  

 

 

  //Authentication
  static String? validateEmail(String? value) {
    String emailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(emailPattern);

    if (value!.isEmpty) {
      return 'Please enter your email address';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    return value!.isEmpty ? 'Please enter your password' : null;
  }

  static String? validateFullName(String? value) {
    return value!.isEmpty ? 'Please enter your fullname' : null;
  }

  //validatePasswordConfirmation
  static String? validatePasswordConfirmation(String? value, String password) {
    if (value!.isEmpty) {
      return 'Please enter your password confirmation';
    } else if (value != password) {
      return 'Password confirmation does not match';
    }
    return null;
  }
}
