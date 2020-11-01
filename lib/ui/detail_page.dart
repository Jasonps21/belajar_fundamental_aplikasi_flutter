import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restauran_app/common/color_constants.dart';
import 'package:restauran_app/custom_widgets/cardmenu_widget.dart';
import 'package:restauran_app/custom_widgets/filter_widget.dart';
import 'package:restauran_app/custom_widgets/floating_widget.dart';
import 'package:restauran_app/custom_widgets/menu_widget.dart';
import 'package:restauran_app/custom_widgets/restaurant_widget.dart';
import 'package:restauran_app/custom_widgets/review_widget.dart';
import 'package:restauran_app/data/api/api_service.dart';
import 'package:restauran_app/data/model/detail_restaurant.dart';
import 'package:restauran_app/data/model/list_restauran.dart'
    as restaurant_list;

class DetailPage extends StatefulWidget {
  static const routeName = '/detail-page';
  final restaurant_list.Restaurant restaurant;
  const DetailPage({Key key, this.restaurant}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<bool> _postReview;
  Future<RestaurantDetail> _detailRestaurant;

  @override
  void initState() {
    _detailRestaurant = ApiService().getDetailRestaurant(widget.restaurant.id);
    super.initState();
  }

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
            children: [
              _buildHero(widget.restaurant, screenWidth, context),
              buildDetail(screenWidth, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetail(double screenWidth, BuildContext context) {
    return FutureBuilder(
      future: _detailRestaurant,
      builder: (context, AsyncSnapshot<RestaurantDetail> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        } else {
          if (snapshot.hasData) {
            var restaurant = snapshot.data.restaurant;
            return _buildDetailRestaurant(restaurant, screenWidth, context);
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

  Column _buildDetailRestaurant(
      Restaurant restaurant, double screenWidth, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: buildNameRestaurant(context, restaurant.name, restaurant.city,
              restaurant.rating.toString()),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 15),
          child: Container(
            height: 50,
            child: ListView.builder(
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              itemCount: restaurant.categories.length,
              itemBuilder: (context, index) {
                return FilterWidget(
                  filterTxt: restaurant.categories[index].name,
                );
              },
            ),
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
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Text(
              restaurant.description ?? "",
              textAlign: TextAlign.justify,
              style: GoogleFonts.notoSans(
                fontSize: 15,
                color: ColorConstant.kGreyColor,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 20),
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
          child: restaurant.menus.foods.length != 0
              ? ListView.builder(
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: restaurant.menus.foods.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: CardMenu(
                          menu: restaurant.menus.foods[index].name,
                          category: 'food'),
                    );
                  },
                )
              : _buildNotFound("Food Not Found"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 20),
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
          child: restaurant.menus.drinks.length != 0
              ? ListView.builder(
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: restaurant.menus.drinks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: CardMenu(
                        menu: restaurant.menus.drinks[index].name,
                        category: 'drink',
                      ),
                    );
                  },
                )
              : _buildNotFound("Drink Not Found"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 20),
          child: Text(
            "Reviews",
            style: GoogleFonts.notoSans(
              fontSize: 16,
              color: ColorConstant.kBlackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          height: 200,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: restaurant.consumerReviews.length != 0
              ? ListView.builder(
                  shrinkWrap: false,
                  scrollDirection: Axis.vertical,
                  itemCount: restaurant.consumerReviews.length,
                  itemBuilder: (context, index) {
                    return ReviewWidget(
                      review: restaurant.consumerReviews[index],
                    );
                  },
                )
              : _buildNotFound("Empty Reviews"),
        ),
        _buildForm(context),
        SizedBox(
          height: 80,
        )
      ],
    );
  }

  Container _buildForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text("Comment This Restaurant",
                  style: GoogleFonts.notoSans(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            TextFormField(
              controller: _controller1,
              decoration: InputDecoration(labelText: 'Your Name'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _controller2,
              decoration: InputDecoration(labelText: 'Comment'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ButtonTheme(
                buttonColor: ColorConstant.kFABBackColor,
                minWidth: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(
                        () {
                          ConsumerReviewPost data = ConsumerReviewPost(
                              id: widget.restaurant.id,
                              name: _controller1.text,
                              review: _controller2.text);
                          _postReview = ApiService().postReview(data);
                        },
                      );
                      if (_postReview != null) {
                        _controller1.clear();
                        _controller2.clear();
                        setState(() {
                          _detailRestaurant = ApiService()
                              .getDetailRestaurant(widget.restaurant.id);
                        });
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Data Berhasil disimpan"),
                          ),
                        );
                      } else {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Data gagal disimpan"),
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    "Submit",
                    style: GoogleFonts.notoSans(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Hero _buildHero(restaurant_list.Restaurant restaurant, double screenWidth,
      BuildContext context) {
    return Hero(
      tag: restaurant.pictureId,
      child: Container(
        height: 220,
        width: screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0)),
          image: DecorationImage(
              image:
                  NetworkImage(ApiService.baseUrlImage + restaurant.pictureId),
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
    );
  }

  Padding _buildNotFound(String text) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Text(
          text,
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
