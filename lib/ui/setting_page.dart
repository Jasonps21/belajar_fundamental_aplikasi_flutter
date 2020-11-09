import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restauran_app/common/color_constants.dart';
import 'package:restauran_app/custom_widgets/custom_dialog.dart';
import 'package:restauran_app/custom_widgets/menu_widget.dart';
import 'package:restauran_app/provider/preference_provider.dart';
import 'package:restauran_app/provider/scheduling_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  static const routeName = '/setting-page';

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMenu(context),
            SizedBox(
              height: 10,
            ),
            Consumer<PreferencesProvider>(builder: (context, provider, index) {
              return Material(
                color: Colors.white,
                child: ListTile(
                  title: Text(
                    'Restaurant Notification',
                    style: GoogleFonts.notoSans(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                      return Switch.adaptive(
                        value: provider.isDailyRestaurantActive,
                        onChanged: (value) async {
                          if (Platform.isIOS) {
                            customDialog(context);
                          } else {
                            scheduled.scheduledNews(value);
                            provider.enableDailyRestaurant(value);
                          }
                        },
                      );
                    },
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Row _buildMenu(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MenuWidget(
          iconImg: Icons.arrow_back,
          iconColor: ColorConstant.kBlackColor,
          onBtnTap: () {
            Navigator.pop(context);
          },
        ),
        Text(
          "Setting",
          style: GoogleFonts.notoSans(
              fontSize: 30,
              color: ColorConstant.kBlackColor,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 50,
        )
      ],
    );
  }
}
