import 'package:dart_frog/dart_frog.dart';

import '../../controllers/login_controllers/login_controllers.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(injectionHandler());
}

Middleware injectionHandler() {
  return (handler) {
    return handler.use(
      provider<LoginControllers>(
        (context) => LoginControllers(),
      ),
    );
  };
}
