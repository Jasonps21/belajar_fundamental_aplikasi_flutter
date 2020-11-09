import 'package:flutter/foundation.dart';
import 'package:restauran_app/data/api/api_service.dart';
import 'package:restauran_app/data/model/list_restauran.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  RestaurantProvider({@required this.apiService}) {
    fetchAllRestaurant();
  }

  RestaurantResult _restaurantResult;
  String _message = "";
  ResultState _state;

  String get message => _message;

  RestaurantResult get result => _restaurantResult;
  ResultState get state => _state;

  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.getListRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = "Error -> $e";
    }
  }
}
