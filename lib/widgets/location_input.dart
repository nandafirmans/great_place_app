import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getCurrentLocation() async {
    final currentLocation = await Location().getLocation();

    print(currentLocation.latitude);
    print(currentLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: _previewImageUrl == null
                ? Center(
                    child: Text(
                      'No Location Chosen',
                      textAlign: TextAlign.center,
                    ),
                  )
                : Image.network(
                    _previewImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                icon: const Icon(Icons.location_on),
                label: const Text('Current Location'),
                textColor: Theme.of(context).primaryColor,
                onPressed: _getCurrentLocation,
              ),
              FlatButton.icon(
                icon: const Icon(Icons.map),
                label: const Text('Select Location'),
                textColor: Theme.of(context).primaryColor,
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
