import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:great_place_app/models/place.dart';
import 'package:great_place_app/utilities/db_helper.dart';

class PlacesProvider extends ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  void addPlace(String title, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: pickedImage,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(DBHelper.TB_NAME_PLACES, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
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
            location: null,
          ),
        )
        .toList();
    notifyListeners();
  }
}
