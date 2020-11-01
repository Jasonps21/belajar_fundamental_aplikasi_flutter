import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:restauran_app/common/color_constants.dart';
import 'package:restauran_app/custom_widgets/menu_widget.dart';
import 'package:restauran_app/custom_widgets/restaurant_widget.dart';
import 'package:restauran_app/data/api/api_service.dart';
import 'package:restauran_app/data/model/search_restaurant.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search-page';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<RestaurantSearch> _restaurantSearch;
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: ColorConstant.kBlackColor.withOpacity(0.32)),
              ),
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                    hintText: "Search Restaurant"),
                onChanged: onSearchTextChanged,
              ),
            ),
            isEmpty
                ? Container(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 200,
                            child:
                                Lottie.asset('assets/search-restaurant.json'),
                          ),
                          Text(
                            "Search your favorite restaurant",
                            style: GoogleFonts.notoSans(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(child: _buildList(context)),
          ],
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    if (text.isEmpty || text == "") {
      isEmpty = true;
      setState(() {});
      return;
    } else {
      isEmpty = false;
      _restaurantSearch = ApiService().getSearchRestaurant(text);
    }
    setState(() {});
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
          "Search",
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

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
      future: _restaurantSearch,
      builder: (context, AsyncSnapshot<RestaurantSearch> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            return snapshot.data.restaurants.length != 0
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = snapshot.data.restaurants[index];
                      return RestaurantWidget(
                        restaurant: restaurant,
                      );
                    },
                  )
                : Container(
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
                            "Not Found",
                            style: GoogleFonts.notoSans(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
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
