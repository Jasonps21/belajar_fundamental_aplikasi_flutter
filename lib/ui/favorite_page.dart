import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app/common/color_constants.dart';
import 'package:restauran_app/custom_widgets/menu_widget.dart';
import 'package:restauran_app/custom_widgets/restaurant_widget.dart';
import 'package:restauran_app/provider/database_provider.dart';
import 'package:restauran_app/utils/result_state.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = '/favorite-page';

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: _buildList(context),
            )
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
          "Favorite",
          style: GoogleFonts.notoSans(
              fontSize: 30,
              color: ColorConstant.kBlackColor,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 50,
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.HasData) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return RestaurantWidget(restaurant: provider.favorites[index]);
            },
          );
        } else {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 180,
                    child: Lottie.asset('assets/empty-data.json'),
                  ),
                  Text(
                    "Empty Data",
                    style: GoogleFonts.notoSans(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
