import 'dart:io';
import 'dart:async';

import 'package:test/test.dart';
import 'dart:convert';

import 'package:dart_uids/config.dart';
import 'package:dart_uids/uid_server.dart';

Future main() async {
  var _config = Config.instance().server;
  final server = new UidServer(_config.host, _config.port);
  setUpAll(() async {
    await server.start();
  });
  tearDownAll(() async {
    expect(server.stop(), completes);
  });
  test('Request to Server', () async {
    var client = new HttpClient();

    HttpClientRequest request =
        await client.get(_config.host, _config.port, '/');
    HttpClientResponse response = await request.close();

    String value = await response.transform(UTF8.decoder).first;
    client.close();

    expect(value.contains(new RegExp(r'\w{6}')), equals(true));
  });
}
