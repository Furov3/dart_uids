import 'dart:async';

import 'package:test/test.dart';

import 'package:dart_uids/config.dart';
import 'package:dart_uids/uid_generator.dart';

void main() {
  Config config;
  UidGenerator generator;
  setUpAll(() {
    config = Config.instance().load('test/config.yaml');
    generator = new UidGenerator();
  });

  //Тестирование последовательной генерации разных uid
  test('different uids', () async {
    final String uid = generator.generate();
    await new Future.delayed(const Duration(seconds: 1));
    expect(generator.generate() == uid, false);
  });

  // Тестирование соответствия параметрам конфигурации
  test('configuration matching', () {
    String uid = generator.generate();
    expect(uid.length, config.uid.length);
    for (String char in uid.split(''))
      expect(config.uid.alphabet.contains(char), true);
  });

  // Тестирование некорректных параметров, которые не дают долгосрочной генерации без повторений
  test('incompatible parameters', () {
    config.load('test/incompatible_config.yaml');
    expect(
        () => new UidGenerator(),
        throwsA(predicate((e) =>
            e is StateError && e.message == 'Wrong configuration parameters')));
  });
}
