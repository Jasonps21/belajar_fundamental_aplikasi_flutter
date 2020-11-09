import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restauran_app/data/model/list_restauran.dart';
import 'package:restauran_app/data/model/detail_restaurant.dart';
import 'package:restauran_app/data/model/search_restaurant.dart';

class ApiService {
  static final String baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String baseUrlImage =
      'https://restaurant-api.dicoding.dev/images/small/';
  static final String list = 'list';
  static final String _detail = 'detail/';
  static final String search = 'search/';
  static final String _review = 'review';

  Future<RestaurantResult> getListRestaurant() async {
    final response = await http.get(baseUrl + list);
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load List Restaurant');
    }
  }

  Future<RestaurantDetail> getDetailRestaurant(String id) async {
    final response = await http.get(baseUrl + _detail + id);
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Detail Restaurant');
    }
  }

  Future<RestaurantSearch> getSearchRestaurant(String text) async {
    final response = await http.get(baseUrl + "$search?q=$text");
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<bool> postReview(ConsumerReviewPost data) async {
    final response = await http.post(
      baseUrl + _review,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'X-Auth-Token': '12345',
      },
      body: jsonEncode(data.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to post review');
    }
  }
}
