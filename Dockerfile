# из образа
FROM google/dart
# создание каталога для проекта
RUN mkdir /dart_uida
# установит рабочим каталогом созданный
WORKDIR /dart_uid
# для нормальной инициализации приложения отдельно загрузить pubspec
ADD pubspec.* /dart_uid/
# обновляются библиотеки на основании pubspec
RUN pub get
# добавляет файлы проекта
ADD . /dart_uid
# второй запуск pub get
RUN pub get --offline
# запуск uid-server 
CMD ["pub", "run", "main.dart"]
