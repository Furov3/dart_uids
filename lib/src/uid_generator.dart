import 'package:dart_uids/config.dart';
import 'dart:math';

/// Генератор уникальных идентификаторов
class UidGenerator {
  /// Текущая конфигурация
  static Config _config = Config.instance();

  /// Конструктор
  ///
  /// Делает проверку на возможность генерации с задаными параметрами
  UidGenerator() {
    if (pow(_config.uid.alphabet.length, _config.uid.length) < 1829088000) {
      throw new StateError('Wrong configuration parameters');
    }
  }

  /// Генерирует uid
  ///
  /// Возвращает значение uid на основе значения текущего времени
  String generate() {
    int difference = new DateTime.now()
        .difference(new DateTime.utc(2018, DateTime.JANUARY, 1))
        .inSeconds;

    //Перевод разницы в систему счисления с основанием, равными длине алфавита
    String uid =
        difference.toRadixString(_config.uid.alphabet.length).toUpperCase();

    //Доведение до необходимой длины
    while (uid.length < _config.uid.length) uid = '0' + uid;

    //Маппинг - замена символов uid на соответствующие в установленном алфавите
    final List<String> defaultAlph =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
    String result = '';
    for (String char in uid.split('')) {
      result += _config.uid.alphabet.split('')[defaultAlph.indexOf(char)];
    }
    return (result);
  }
}
