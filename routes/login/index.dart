import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import '../../controllers/login_controllers/login_controllers.dart';

Future<Response> onRequest(
  RequestContext context,
) async {
  final controller = context.read<LoginControllers>();
  final reqBody = jsonDecode(await context.request.body()) as Map<String, dynamic>;
  Response? response;
  if (context.request.method == HttpMethod.post) {
    await controller.loginVerify(reqBody).then((value) async {
      await controller.loginController(reqBody).then((value) {
        response = Response.json(body: value);
      }).onError((error, stackTrace) {
        response = Response.json(statusCode: 400, body: controller.generateOkResMap(path: '/login', message: error.toString(), data: {}, success: false));
      });
    }).onError((error, stackTrace) {
      print('loginVerify error: $error');
      response = Response.json(statusCode: 400, body: controller.generateOkResMap(path: '/login', message: error.toString(), data: {}, success: false));
    });
  } else {
    response = Response.json(statusCode: 404, body: {});
  }
  return response!;
}
