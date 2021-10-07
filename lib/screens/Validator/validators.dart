class ValidateTextField {
  static String? validatephone(value) {
    if (value!.isEmpty) {
      return 'Required *';
    } else if (value.length < 10) {
      return 'atleast 10 digit';
    } else {
      return null;
    }
  }

  static String? validatepassword(value) {
    if (value!.isEmpty) {
      return 'Required *';
    } else if (value.length < 6) {
      return 'atleast 6 digit';
    } else {
      return null;
    }
  }

  static String? validateNull(value) {
    if (value!.isEmpty) {
      return 'Required *';
    } else {
      return null;
    }
  }
}
