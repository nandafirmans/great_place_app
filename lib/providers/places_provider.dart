import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:great_place_app/models/place.dart';
import 'package:great_place_app/utilities/db_helper.dart';
import 'package:great_place_app/utilities/location_helper.dart';

class PlacesProvider extends ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  Place findById(String id) {
    return _items.firstWhere((p) => p.id == id);
  }

  Future<void> addPlace(
    String title,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
    );
    pickedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: pickedImage,
      location: pickedLocation,
    );

    _items.add(newPlace);

    notifyListeners();

    DBHelper.insert(DBHelper.TB_NAME_PLACES, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'location_lat': newPlace.location.latitude,
      'location_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final places = await DBHelper.getData(DBHelper.TB_NAME_PLACES);
    _items = places
        .map(
          (p) => Place(
            id: p['id'],
            title: p['title'],
            image: File(p['image']),
            location: PlaceLocation(
              latitude: p['location_lat'],
              longitude: p['location_lng'],
              address: p['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
