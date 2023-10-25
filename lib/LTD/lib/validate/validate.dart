

import 'package:validators/validators.dart';

String? validatorEmail(String value) {
  if (value.isEmpty) {
    return "Vui lòng không để trống ";
  } else if (!isEmail(value)) {
    return "Vui lòng nhập email! ";
  }
  return null;
}

String? validatorPassword(String str, int minLength) {
  return str != null && isLength(str, minLength) ? null : "Vui lòng nhập nhiều hơn $minLength kí tự";
}

String? validatorPhone(String value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{9,10}$)';

  RegExp regExp = RegExp(patttern);
  if (!regExp.hasMatch(value)) return 'Vui lòng nhập số điện thoại';

  return null;
}

String? validatorConfirmPassword(String password, String repassword) {
  if (repassword.length < 6) {
    return "Vui lòng nhập nhiều hơn 6 kí tự";
  } else if (repassword != password) {
    return "Mật khẩu không trùng khớp!";
  }
  return null;
}

String? validatorText(String value) {
  if(value.isEmpty) {
    return "Vui lòng không để trống";
  }
  return null;
}