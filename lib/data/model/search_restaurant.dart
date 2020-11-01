import 'package:restauran_app/data/model/list_restauran.dart';

class RestaurantSearch {
  RestaurantSearch({
    this.error,
    this.founded,
    this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurant> restaurants;

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantSearch(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}
