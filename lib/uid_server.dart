import 'dart:io';
import 'dart:async';
import 'package:dart_uids/src/uid_generator.dart';

/// HTTP_UID сервер
class UidServer {
  /// конструктор HTTP сервера
  final int _port;
  final String _host;
  UidServer(String host, int port)
      : _host = host,
        _port = port;

  HttpServer _server;

  /// Запускает сервер и слушает запросы
  Future start() async {
    /// Инициализация сервера с
    _server = await HttpServer.bind(
      _host,
      _port,
    );

    /// Печатает в консоль отчет о успешном запуске и актуальном адрес:порт
    /// считанном из запущенного сервера
    print('Listening on ${_server.address}:${_server.port}');

    /// Обрабатывает запрос к серверу
    _server.listen(_handleRequest);
  }

  /// Останавливает сервер
  Future stop() async {
    /// Закрывает экземпляр сервера по команде диспетчера
    await _server.close();
  }
}

/// Функция обработки запроса и ответа на него
void _handleRequest(request) {
  ///преверка запроса на валидность
  if (request.method == 'GET' && request.uri.path == "/") {
    /// если запрос валидный то получение UID и ответ клиенту
    String uid = new UidGenerator().generate();
    request.response.write(uid);
  } else {
    /// если запрос плохой ответ bad request
    request.response.statusCode = HttpStatus.BAD_REQUEST;
  }

  /// Закрывает ответ
  request.response.close();
}