import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app/common/navigation.dart';
import 'package:restauran_app/data/api/api_service.dart';
import 'package:restauran_app/data/db/database_helper.dart';
import 'package:restauran_app/data/preference/preferences_helper..dart';
import 'package:restauran_app/provider/database_provider.dart';
import 'package:restauran_app/provider/preference_provider.dart';
import 'package:restauran_app/provider/restaurant_provider.dart';
import 'package:restauran_app/provider/scheduling_provider.dart';
import 'package:restauran_app/ui/detail_page.dart';
import 'package:restauran_app/ui/favorite_page.dart';
import 'package:restauran_app/ui/home_page.dart';
import 'package:restauran_app/ui/search_page.dart';
import 'package:restauran_app/ui/setting_page.dart';
import 'package:restauran_app/ui/splash_screen.dart';
import 'package:restauran_app/utils/background_service.dart';
import 'package:restauran_app/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Restauran App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          HomePage.routeName: (context) => HomePage(),
          FavoritePage.routeName: (context) => FavoritePage(),
          SearchPage.routeName: (context) => SearchPage(),
          SettingPage.routeName: (context) => SettingPage(),
          DetailPage.routeName: (context) =>
              DetailPage(restaurant: ModalRoute.of(context).settings.arguments),
        },
      ),
    );
  }
}
