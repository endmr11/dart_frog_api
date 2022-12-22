import 'package:dart_frog/dart_frog.dart';

import '../managers/db_manager.dart';
import '../managers/socket_manager.dart';

Future<Response> onRequest(RequestContext context) async {
  final dbManager = DbManager();
  final socketManager = SocketManager();
  final dbConnection = await dbManager.initDb();
  print('initDb $dbConnection');
  if (!dbConnection) {
    return Response(statusCode: 404,body: 'DB Error!'); 
  }
  await socketManager.initSocket();
  return Response(body: 'Welcome to Dart Frog!');
}
