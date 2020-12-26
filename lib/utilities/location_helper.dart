import 'dart:convert';

import 'package:http/http.dart';

class LocationHelper {
  static const _MAP_API_HOST = 'https://api.mapbox.com';
  static const _MAP_API_KEY = 'pk.eyJ1IjoibmFuZGFmaXJtYW5zIiwiYSI6ImNqMnJwaTc5MzAwODkzMmt6Mm80aTZkMzQifQ.VT0pLQaw39iOMzIZaGAH4A';

  static String getLocationImage({double latitude, double longitude}) {
    return '$_MAP_API_HOST/styles/v1/mapbox/outdoors-v11/static/pin-l-circle+e13d3d($longitude,$latitude)/$longitude,$latitude,15,0/600x300@2x?access_token=$_MAP_API_KEY';
  }

  static Future<String> getPlaceAddress({double latitude, double longitude}) async {
    final urlGetPlace = '$_MAP_API_HOST/geocoding/v5/mapbox.places/$longitude,$latitude.json?types=address&access_token=$_MAP_API_KEY';
    final response = await get(urlGetPlace);
    final responseBody = json.decode(response.body);

    if (responseBody['features'] == null) return null;

    return responseBody['features'][0]['place_name'];
  }
}
