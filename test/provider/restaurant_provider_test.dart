import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restauran_app/data/api/api_service.dart';
import 'package:restauran_app/data/model/list_restauran.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('Get All Restaurant', () {
    var dataRestaurant = {
      "restaurants": [
        {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description":
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
          "pictureId": "14",
          "city": "Medan",
          "rating": 4.2
        },
      ]
    };

    test('Get data Restaurant Result', () async {
      final client = MockClient();

      when(client.get(ApiService.baseUrl + ApiService.list)).thenAnswer(
          (_) async => http.Response(jsonEncode(dataRestaurant), 200));

      expect(await ApiService().getListRestaurant(), isA<RestaurantResult>());
    });
  });
}
