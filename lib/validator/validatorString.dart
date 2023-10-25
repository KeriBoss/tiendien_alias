import 'package:validators/validators.dart';

String? validatorText(String value) {
  if (value.isEmpty) {
    return "Vui lòng không để trống";
  }
  return null;
}

String? validatorEmail(String value) {
  if (value.isEmpty) {
    return "Vui lòng không để trống ";
  } else if (!isEmail(value)) {
    return "Vui lòng nhập email! ";
  }
  return null;
}

String? validatorPasswordLength(String str, int minLength) {
  return str != null && isLength(str, minLength)
      ? null
      : "Vui lòng nhập nhiều hơn $minLength kí tự";
}

String? validatorLength(String str, int minLength) {
  print(str);
  return str != null && isLength(str, minLength)
      ? null
      : "Vui lòng nhập nhiều hơn $minLength kí tự";
}

String? validatorPhoneNumber(String value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10}$)';

  RegExp regExp = RegExp(patttern);
  if (!regExp.hasMatch(value)) return 'Vui lòng nhập số điện thoại';

  return null;
}

String? validateVerifyPassword(String password, String repassword) {
  if (repassword.isEmpty) {
    return "Vui lòng không để trống ";
  }
  if (repassword != password) {
    return "Mật khẩu không trùng khớp!";
  }
  return null;
}

String? validateNumber(String str,) {
  if (!isNumeric(str)) {
    return "Vui lòng nhập số";
  }
  return null;
}

String? validatorMin(String str,) {
  if (!isNumeric(str)) {
    return "Vui lòng nhập số";
  } else if (int.parse(str) > 30) {
    return "Vui lòng nhập số phần trăm bé hơn 30";
  }
  return null;
}

String? validatorYear(String str) {
  if (str.length != 4) {
    return "Vui lòng nhập năm sinh";
  }
  return null;
}

String? validatorCCCD(String str) {
  if (str.length != 12) {
    return "Vui lòng nhập đúng số CCCD";
  }
  return null;
}

