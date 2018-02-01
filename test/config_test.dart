import 'package:test/test.dart';

import 'package:dart_uids/config.dart';

void main() {
  Config config;
  setUpAll(() {
    config = Config.instance().load('test/config.yaml');
  });

  // Тестирование получения номера порта
  test('port getter', () {
    expect(config.server.port, 3000);
  });

  // Тестирование получения адреса сервера
  test('host getter', () {
    expect(config.server.host, '0.0.0.0');
  });

  // Тестирование получения длины UID
  test('uid length getter', () {
    expect(config.uid.length, 6);
  });

  // Тестирование получения алфавита UID
  test('alphabet getter', () {
    expect(config.uid.alphabet, '0123456789ABCDEFGHIJKLMNPQRSTUVWXYZ');
  });

  // Тестирование загрузки конфигурации с неуказанными параметрами
  test('incomplete config', () {
    config.load('test/incomplete_config.yaml');
    expect(config.server.port, 7777);
    expect(config.server.host, '0.0.0.0');
    expect(config.uid.length, 6);
    expect(config.uid.alphabet, '0123456789ABCDEFGHIJKLMNPQRSTUVWXYZ');
  });

  // Тестирование загрузки конфигурации с некорректными параметрами
  test('incorrect config', () {
    expect(
        () => config.load('test/incorrect_config.yaml'),
        prints('Port is incorrect!\n'
            'Host is incorrect!\n'
            'UID length is incorrect!\n'
            'UID alphabet is incorrect!\n'));
    expect(config.server.port, 7777);
    expect(config.server.host, '0.0.0.0');
    expect(config.uid.length, 6);
    expect(config.uid.alphabet, '0123456789ABCDEFGHIJKLMNPQRSTUVWXYZ');
  });

  // Тестирование FileSystemException при загрузке файла конфигурации
  test('file system exception', () {
    expect(
        () => config.load('test/konfig.yaml'), prints('FileSystemException\n'));
  });

  // Тестирование загрузки некорректного конфигурационного файла
  test('wrong config format', () {
    expect(() => config.load('test/not_yaml_file'),
        prints('Format of the loaded config is incorrect!\n'));
  });
}
