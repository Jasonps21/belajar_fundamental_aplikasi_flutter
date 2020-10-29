import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restauran_app/common/color_constants.dart';
import 'package:restauran_app/custom_widgets/filter_widget.dart';
import 'package:restauran_app/custom_widgets/menu_widget.dart';
import 'package:restauran_app/custom_widgets/restaurant_widget.dart';
import 'package:restauran_app/data/model/restauran.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home-page';
  final filterArrays = ['Breakfast', 'Dessert', 'Lunch', 'Cake'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMenu(),
            SizedBox(
              height: 20,
            ),
            _buildFilter(),
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

  Container _buildFilter() {
    return Container(
      height: 50,
      child: ListView.builder(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemCount: filterArrays.length,
        itemBuilder: (context, index) {
          return FilterWidget(
            filterTxt: filterArrays[index],
          );
        },
      ),
    );
  }

  Row _buildMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MenuWidget(
            iconImg: Icons.subject, iconColor: ColorConstant.kBlackColor),
        Text(
          "Restaurant",
          style: GoogleFonts.notoSans(
              fontSize: 30,
              color: ColorConstant.kBlackColor,
              fontWeight: FontWeight.w600),
        ),
        MenuWidget(iconImg: Icons.repeat, iconColor: ColorConstant.kBlackColor),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        final List<Restaurant> restaurant = parceRestaurant(snapshot.data);
        return restaurant.length != 0
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return RestaurantWidget(
                    restaurant: restaurant[index],
                  );
                },
                itemCount: restaurant.length)
            : Center(
                child: Text("Data Not Found",
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: ColorConstant.kBlackColor,
                      fontWeight: FontWeight.bold,
                    )));
      },
    );
  }
}
