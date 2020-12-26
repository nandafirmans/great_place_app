import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_place_app/models/place.dart';
import 'package:great_place_app/providers/places_provider.dart';
import 'package:great_place_app/widgets/image_input.dart';
import 'package:great_place_app/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static String routeName = '/add_place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _handleOnSelectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _handleOnSelectLocation({double latitude, double longitude}) {
    _pickedLocation = PlaceLocation(
      latitude: latitude,
      longitude: longitude,
    );
  }

  void _savePlace() {
    final title = _titleController.text;
    if (title.isEmpty || _pickedImage == null || _pickedLocation == null) {
      return;
    }
    context
        .read<PlacesProvider>()
        .addPlace(title, _pickedImage, _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    controller: _titleController,
                  ),
                  const SizedBox(height: 20),
                  ImageInput(
                    onSelectImage: _handleOnSelectImage,
                  ),
                  const SizedBox(height: 20),
                  LocationInput(
                    onSelectLocation: _handleOnSelectLocation,
                  ),
                ],
              ),
            ),
          ),
          RaisedButton.icon(
            elevation: 0,
            //remove button margin
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
            onPressed: _savePlace,
          )
        ],
      ),
    );
  }
}
