/// Конфигурация для генератора UID
class UIDConfig {
  /// Значение [_length] по умолчанию
  static const DEFAULT_LENGTH = 6;

  /// Значение [_alphabet] по умолчанию
  static const DEFAULT_ALPHABET = '0123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';

  /// Длина сгенерированного UID
  int _length;

  /// Символы алфавита для генерации UID
  String _alphabet;

  /// Конструктор
  ///
  /// Устанавливает параметры конфигурации [uid], если они переданы и корректны.
  UIDConfig([Map uid]) {
    if (uid != null) {
      if (uid.containsKey('length')) {
        if (uid['length'] is int)
          _length = uid['length'];
        else
          print('UID length is incorrect!');
      }
      if (uid.containsKey('alphabet')) {
        if (uid['alphabet'] is String)
          _alphabet = uid['alphabet'];
        else
          print('UID alphabet is incorrect!');
      }
    }
  }

  /// Если параметр [_length] не был указан или был указан некорректно,
  /// то возвращается значение по умолчанию.
  get length => _length == null ? DEFAULT_LENGTH : _length;

  /// Если параметр [_alphabet] не был указан или был указан некорректно,
  /// то возвращается значение по умолчанию.
  get alphabet => _alphabet == null ? DEFAULT_ALPHABET : _alphabet;
}
