import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class AuthManager {
  JWT? jwt;

  final String secretKey = 'eren34demir';

  JWT get myJwt => jwt!;
  void setJwtPayload(String email) {
    jwt = JWT({'email': email, 'iss': 'http://localhost:8080'});
  }

  int jwtVerify(String token) {
    try {
      jwt = JWT.verify(token, SecretKey(secretKey));
      return 0;
    } catch (e) {
      if (e is JWTExpiredError) {
        return 1;
      } else if (e is JWTError) {
        return 2;
      } else {
        return 2;
      }
    }
  }
}
