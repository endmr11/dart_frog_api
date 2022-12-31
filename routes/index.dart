import 'package:dart_frog/dart_frog.dart';

import '../managers/db_manager.dart';
import '../managers/socket_manager.dart';

Future<Response> onRequest(RequestContext context) async {
  final dbManager = DbManager();
  final socketManager = SocketManager();
  Response? response;
  await dbManager.initDb().then((value)async{
    await socketManager.initSocket().then((value){
      response = Response(body: 'Welcome to Dart Frog!');
    }).onError((error, stackTrace){
      response = Response(body:error.toString());
    });
  }).onError((error, stackTrace){
    response =  Response(statusCode: 404,body: 'DB Error!');
  });
  return response!;
}
