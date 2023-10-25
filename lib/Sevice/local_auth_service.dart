import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();

  static Future<bool> _canAuthenticate() async {
    try {

      return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    } on PlatformException catch (e) {
      return false;
    }

  }

  static Future<bool> authenticate() async {
    try {
      if(!await _canAuthenticate()) return false;

      return await _auth.authenticate(
          localizedReason: 'Sử dụng Face ID để xác thực',
          authMessages: const [
            AndroidAuthMessages(

                signInTitle: 'Xác thực',
                cancelButton: 'Không, cám ơn'
            ),
            IOSAuthMessages(
                cancelButton: 'Không, cám ơn'
            )
          ],
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
            biometricOnly: true,
          )
      );
    } catch (e) {
      debugPrint('error $e');
      return false;
    }
  }
}