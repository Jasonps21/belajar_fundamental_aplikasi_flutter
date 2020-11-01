import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restauran_app/common/color_constants.dart';
import 'package:restauran_app/custom_widgets/filter_widget.dart';
import 'package:restauran_app/custom_widgets/menu_widget.dart';
import 'package:restauran_app/custom_widgets/restaurant_widget.dart';
import 'package:restauran_app/data/api/api_service.dart';
import 'package:restauran_app/data/model/list_restauran.dart';
import 'package:restauran_app/ui/search_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final filterArrays = ['Breakfast', 'Dessert', 'Lunch', 'Cake'];

  Future<RestaurantResult> _restaurant;

  @override
  void initState() {
    _restaurant = ApiService().getListRestaurant();
    super.initState();
  }

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
          iconImg: Icons.subject,
          iconColor: ColorConstant.kBlackColor,
          onBtnTap: () {},
        ),
        Text(
          "Restaurant",
          style: GoogleFonts.notoSans(
              fontSize: 30,
              color: ColorConstant.kBlackColor,
              fontWeight: FontWeight.w600),
        ),
        MenuWidget(
          iconImg: Icons.search,
          iconColor: ColorConstant.kBlackColor,
          onBtnTap: () {
            Navigator.pushNamed(context, SearchPage.routeName);
          },
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
      future: _restaurant,
      builder: (context, AsyncSnapshot<RestaurantResult> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = snapshot.data.restaurants[index];
                return RestaurantWidget(
                  restaurant: restaurant,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Text("");
          }
        }
      },
    );
  }
}
