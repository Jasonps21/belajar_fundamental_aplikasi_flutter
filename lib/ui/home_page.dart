import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app/common/color_constants.dart';
import 'package:restauran_app/custom_widgets/filter_widget.dart';
import 'package:restauran_app/custom_widgets/menu_widget.dart';
import 'package:restauran_app/custom_widgets/restaurant_widget.dart';
import 'package:restauran_app/data/api/api_service.dart';
import 'package:restauran_app/data/model/list_restauran.dart';
import 'package:restauran_app/provider/restaurant_provider.dart';
import 'package:restauran_app/ui/detail_page.dart';
import 'package:restauran_app/ui/favorite_page.dart';
import 'package:restauran_app/ui/search_page.dart';
import 'package:restauran_app/ui/setting_page.dart';
import 'package:restauran_app/utils/background_service.dart';
import 'package:restauran_app/utils/notification_helper.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final filterArrays = ['Breakfast', 'Dessert', 'Lunch', 'Cake'];

  Future<RestaurantResult> _restaurant;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  @override
  void initState() {
    _restaurant = ApiService().getListRestaurant();
    port.listen((_) async => await _service.someTask());
    _notificationHelper
        .configureSelectNotificationSubject(DetailPage.routeName);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: null,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg-drawer.jpg'),
                    fit: BoxFit.cover),
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.home,
                      size: 30,
                      color: ColorConstant.kFABBackColor,
                    ),
                  ),
                  GestureDetector(
                    child: Text('Home',
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.kFABBackColor,
                        )),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.favorite,
                      size: 30,
                      color: ColorConstant.kFABBackColor,
                    ),
                  ),
                  GestureDetector(
                    key: Key('favorite_page_button'),
                    child: Text('Favorite',
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.kFABBackColor,
                        )),
                    onTap: () {
                      Navigator.popAndPushNamed(
                          context, FavoritePage.routeName);
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.settings,
                      size: 30,
                      color: ColorConstant.kFABBackColor,
                    ),
                  ),
                  GestureDetector(
                    child: Text('Setting',
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.kFABBackColor,
                        )),
                    onTap: () {
                      Navigator.popAndPushNamed(context, SettingPage.routeName);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
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
          keyText: Key('menu_drawer_button'),
          iconImg: Icons.subject,
          iconColor: ColorConstant.kBlackColor,
          onBtnTap: () => _scaffoldKey.currentState.openDrawer(),
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
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var restaurant = state.result.restaurants[index];
                return RestaurantWidget(restaurant: restaurant);
              },
              itemCount: state.result.restaurants.length);
        } else if (state.state == ResultState.NoData) {
          return Center(
            child: Text(state.message),
          );
        } else if (state.state == ResultState.Error) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Center(
            child: Text(''),
          );
        }
      },
    );
  }
}
