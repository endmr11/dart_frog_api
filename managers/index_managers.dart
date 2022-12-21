import '../utils/response_handler.dart';
import 'auth_manager.dart';
import 'db_manager.dart';
import 'socket_manager.dart';

abstract class Managers with ResponseHandler {
  final dbManager = DbManager();
  final jwtAuth = AuthManager();
  final socketManager = SocketManager();
}
