/// Конфигурация для http сервера
class ServerConfig {
  /// Значение [_port] по умолчанию
  static const DEFAULT_PORT = 7777;

  /// Значение [_host] по умолчанию
  static const DEFAULT_HOST = '0.0.0.0';

  /// Номер порта
  int _port;

  /// Адрес сервера
  String _host;

  /// Конструктор
  ///
  /// Устанавливает параметры конфигурации [server], если они переданы и корректны.
  ServerConfig([Map server]) {
    if (server != null) {
      if (server.containsKey('port')) {
        if (server['port'] is int &&
            server['port'] > 0 &&
            server['port'] < 65535)
          _port = server['port'];
        else
          print('Port is incorrect!');
      }
      if (server.containsKey('host')) {
        if (server['host'] is String)
          _host = server['host'];
        else
          print('Host is incorrect!');
      }
    }
  }

  /// Если параметр [_port] не был указан или был указан некорректно,
  /// то возвращается значение по умолчанию.
  get port => _port == null ? DEFAULT_PORT : _port;

  /// Если параметр [_host] не был указан или был указан некорректно,
  /// то возвращается значение по умолчанию.
  get host => _host == null ? DEFAULT_HOST : _host;
}
