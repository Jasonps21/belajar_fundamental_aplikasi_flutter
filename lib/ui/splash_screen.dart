import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:restauran_app/common/color_constants.dart';
import 'package:restauran_app/ui/home_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash-screen';
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _home(),
        builder: (context, snapshot) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Lottie.asset('assets/animate-loading.json'),
                  ),
                  SizedBox(
                    height: 80,
                    child: Text(
                      "Restaurant App",
                      style: GoogleFonts.notoSans(
                          fontSize: 30,
                          color: ColorConstant.kBlackColor,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<String> _home() async {
    await Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return HomePage();
          },
        ),
      );
    });

    return "Splash";
  }
}
