import 'package:flutter/material.dart';
import 'package:restauran_app/ui/detail_page.dart';
import 'package:restauran_app/ui/home_page.dart';
import 'package:restauran_app/ui/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Restauran App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: SplashScreen(),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          HomePage.routeName: (context) => HomePage(),
          DetailPage.routeName: (context) =>
              DetailPage(restaurant: ModalRoute.of(context).settings.arguments),
        });
  }
}
