import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Restaurant App testing', () {
    FlutterDriver driver;

    Future<FlutterDriver> setupAndGetDriver() async {
      FlutterDriver driver = await FlutterDriver.connect();
      var connected = false;
      while (!connected) {
        try {
          await driver.waitUntilFirstFrameRasterized();
          connected = true;
        } catch (error) {}
      }
      return driver;
    }

    setUpAll(() async {
      driver = await setupAndGetDriver();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test(
      'set Favorite 2 Restaurant dan menampilkan data Favorite serta membuka salah satu detail restaurant',
      () async {
        final keys = [
          'Melting Pot',
          'Kafe Kita',
        ];

        for (var key in keys) {
          await driver.tap(find.byValueKey(key));
        }

        // Open the drawer
        await driver.tap(find.byValueKey('menu_drawer_button'));

        SerializableFinder fab = find.byValueKey('favorite_page_button');

        // Wait for the floating action button to appear
        await driver.waitFor(fab);

        // Tap on the fab
        await driver.tap(fab);

        await driver.tap(find.byValueKey(keys[0] + '_page'));

        sleep(Duration(seconds: 6));
      },
    );
  }, timeout: Timeout(Duration(minutes: 2)));
}
