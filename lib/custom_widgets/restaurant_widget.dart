import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restauran_app/common/color_constants.dart';
import 'package:restauran_app/data/model/restauran.dart';
import 'package:restauran_app/ui/detail_page.dart';

class RestaurantWidget extends StatelessWidget {
  final Restaurant restaurant;
  final int imgPathindex;
  final List<String> imgList;

  const RestaurantWidget(
      {Key key, this.restaurant, this.imgPathindex, this.imgList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, DetailPage.routeName,
                arguments: restaurant);
          },
          child: Hero(
            tag: restaurant.pictureId,
            child: Container(
              height: 160,
              width: screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                    image: NetworkImage(restaurant.pictureId),
                    fit: BoxFit.fitWidth),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: ColorConstant.kWhiteColor,
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Icon(Icons.favorite_border),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(restaurant.name,
                  style: GoogleFonts.notoSans(
                      fontSize: 22, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 0, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(restaurant.city,
                  style: GoogleFonts.notoSans(
                      fontSize: 16, color: ColorConstant.kGreyColor)),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 16,
                  ),
                  Text(restaurant.rating.toString(),
                      style: GoogleFonts.notoSans(
                          fontSize: 16, color: ColorConstant.kGreyColor))
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
