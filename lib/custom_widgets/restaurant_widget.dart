import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restauran_app/common/color_constants.dart';
import 'package:restauran_app/data/api/api_service.dart';
import 'package:restauran_app/data/model/list_restauran.dart';
import 'package:restauran_app/ui/detail_page.dart';

class RestaurantWidget extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantWidget({Key key, this.restaurant}) : super(key: key);

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
          child: restaurant.pictureId == null
              ? Container(
                  width: 100,
                  child: Icon(Icons.error),
                )
              : Hero(
                  tag: restaurant.pictureId,
                  child: Container(
                    height: 160,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                          image: NetworkImage(
                              ApiService.baseUrlImage + restaurant.pictureId),
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
        buildNameRestaurant(context, restaurant.name, restaurant.city,
            restaurant.rating.toString()),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 0, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
          ),
        ),
      ],
    );
  }
}

Container buildNameRestaurant(
    BuildContext context, String name, String city, String rating) {
  return Container(
    padding: EdgeInsets.only(left: 10, top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name ?? "",
              style: GoogleFonts.notoSans(
                fontSize: 22,
                color: ColorConstant.kBlackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              city ?? "",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: Container(
            height: 40,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
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
                    rating.toString() ?? "0",
                    style: Theme.of(context).textTheme.caption.copyWith(
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
  );
}
