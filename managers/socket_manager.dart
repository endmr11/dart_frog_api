// ignore_for_file: cascade_invocations

import 'dart:async';
import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketManager {
  static io.Socket socket = io.io('http://localhost:8083', <String, dynamic>{
    'transports': ['websocket'],
  });

  Future<bool> initSocket() async {
    final completer = Completer<bool>();
    try {
      socket..onConnect((_) {
        socket.emit('isConnected', 'yes');
        completer.complete(true);
      })
      ..on('connectionStatus', (_) => log('Result => $_'))
          ..onConnectError((data){
            completer.completeError(data.toString());
          })
          ..onConnectTimeout((data){
            completer.completeError(data.toString());
          });
    } catch (e) {
      log(e.toString());
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<void> createOrderSend(dynamic data) async {
    if (socket.connected) {
      try {
        socket.emit('createOrderSend', data);
        socket.on('createOrderResponse', (_) => log('Result => $_'));
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<void> updateOrderSend(dynamic data) async {
    if (socket.connected) {
      try {
        socket.emit('updateOrderSend', data);
        socket.on('updateOrderResponse', (_) => log('Result => $_'));
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<void> deleteOrderSend(dynamic data) async {
    if (socket.connected) {
      try {
        socket.emit('deleteOrderSend', data);
        socket.on('deleteOrderResponse', (_) => log('Result => $_'));
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
