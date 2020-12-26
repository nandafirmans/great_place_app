import 'package:flutter/material.dart';
import 'package:great_place_app/models/place.dart';
import 'package:great_place_app/providers/places_provider.dart';
import 'package:great_place_app/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static String routeName = '/place_detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace = Provider.of<PlacesProvider>(context).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => MapScreen(
                  initialLocation: selectedPlace.location,
                ),
              ),
            ),
            child: Text('View on Map'),
            textColor: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
