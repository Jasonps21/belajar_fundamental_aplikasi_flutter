import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restauran_app/common/color_constants.dart';
import 'package:restauran_app/custom_widgets/cardmenu_widget.dart';
import 'package:restauran_app/custom_widgets/floating_widget.dart';
import 'package:restauran_app/custom_widgets/menu_widget.dart';
import 'package:restauran_app/data/model/restauran.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail-page';
  final Restaurant restaurant;
  const DetailPage({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConstant.kWhiteColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        width: screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingWidget(
              icon: Icons.map,
              text: "Location",
            ),
            FloatingWidget(
              icon: Icons.call,
              text: "Call",
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: restaurant.pictureId,
                child: Container(
                  height: 220,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                    image: DecorationImage(
                        image: NetworkImage(restaurant.pictureId),
                        fit: BoxFit.fill),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          right: 15,
                          left: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            MenuWidget(
                              iconImg: Icons.arrow_back,
                              iconColor: ColorConstant.kWhiteColor,
                              conBackColor: Colors.transparent,
                              onBtnTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            MenuWidget(
                              iconImg: Icons.favorite_border,
                              iconColor: ColorConstant.kWhiteColor,
                              conBackColor: Colors.transparent,
                              onBtnTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: GoogleFonts.notoSans(
                            fontSize: 25,
                            color: ColorConstant.kBlackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            restaurant.city,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Container(
                        height: 45,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: Colors.grey[200])),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                restaurant.rating.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10, left: 15),
                child: Text(
                  "Description",
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    color: ColorConstant.kBlackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  child: Text(
                    restaurant.description,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.notoSans(
                      fontSize: 15,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Food",
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    color: ColorConstant.kBlackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 100,
                child: restaurant.menu.foods.length != 0
                    ? ListView.builder(
                        shrinkWrap: false,
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurant.menu.foods.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: CardMenu(
                                menu: restaurant.menu.foods[index],
                                category: 'food'),
                          );
                        },
                      )
                    : _buildNotFound(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  "Drink",
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    color: ColorConstant.kBlackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 100,
                child: restaurant.menu.drinks.length != 0
                    ? ListView.builder(
                        shrinkWrap: false,
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurant.menu.drinks.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: CardMenu(
                              menu: restaurant.menu.drinks[index],
                              category: 'drink',
                            ),
                          );
                        },
                      )
                    : _buildNotFound(),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildNotFound() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Text(
          "Food Not Found",
          style: GoogleFonts.notoSans(
            fontSize: 14,
            color: ColorConstant.kBlackColor,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
