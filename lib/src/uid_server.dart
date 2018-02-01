import 'dart:io';
import 'dart:async';

import 'package:dart_uids/uid_generator.dart';

/// HTTP_UID сервер.
class UidServer {
  /// HTTP_UID сервер.
  HttpServer _server;

  /// порт HTTP сервера.
  final int _port;

  /// адрес HTTP сервера.
  final String _host;

  /// создает UID сервер.
  UidServer(String host, int port)
      : _host = host,
        _port = port;

  /// Запускает сервер и слушает запросы.
  Future start() async {
    // Инициализация сервера.
    _server = await HttpServer.bind(
      _host,
      _port,
    );

    print('Listening on ${_server.address}:${_server.port}');

    _server.listen(_handleRequest);
  }

  /// Останавливает сервер.
  Future stop() async {
    await _server.close();
  }
}

/// Обрабатывает запрос к серверу
void _handleRequest(request) {
  // преверка запроса на валидность.
  if (request.method == 'GET' && request.uri.path == "/") {
    // если запрос валидный то получение UID и ответ клиенту.
    String uid = new UidGenerator().generate();
    request.response.write(uid);
  } else {
    // если запрос плохой ответ bad request.
    request.response.statusCode = HttpStatus.BAD_REQUEST;
  }

  request.response.close();
}
