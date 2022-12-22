import 'dart:async';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../../managers/index_managers.dart';

class LoginControllers extends Managers {
  Future<bool> loginVerify(Map<String, dynamic> reqBody) async {
    print('loginVerify');
    final completer = Completer<bool>();
    final email = reqBody['email'];
    print('loginVerify2: $email');
    final password = reqBody['password'];
    print('loginVerify3: $password');
    final userExist = await dbManager.userExist('$email', '$password');
    print('loginVerify4: $userExist');
    if (!userExist) {
      completer.completeError('Login Error');
    } else {
      completer.complete(true);
    }
    return completer.future;
  }

  Future<Map<String, dynamic>> loginController(Map<String, dynamic> reqBody) async {
    final completer = Completer<Map<String, dynamic>>();
    final email = reqBody['email'];
    try {
      jwtAuth.setJwtPayload('$email');
      final token = jwtAuth.myJwt.sign(SecretKey(jwtAuth.secretKey), expiresIn: const Duration(days: 1));
      final userInfo = await dbManager.getUserInfo('$email');
      final model = <Map<String, dynamic>>[];
      for (final element in userInfo) {
        final modelMap = <String, dynamic>{
          'id': element[0],
          'name': element[1],
          'surname': element[2],
          'email': element[3],
          'token': token,
          'user_type': element[5],
        };
        model.add(modelMap);
      }
      final responseMap = generateOkResMap(path: '/login', message: 'Success', data: model, success: true);
      completer.complete(responseMap);
    } catch (error) {
      completer.completeError(error.toString());
    }
    return completer.future;
  }
}
