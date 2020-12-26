import 'package:flutter/material.dart';
import 'package:great_place_app/screens/map_screen.dart';
import 'package:great_place_app/utilities/location_helper.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:transparent_image/transparent_image.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectLocation;

  const LocationInput({Key key, @required this.onSelectLocation})
      : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _onSelectLocation({double latitude, double longitude}) {
    widget.onSelectLocation(latitude: latitude, longitude: longitude);
  }

  void _setPreviewImage({double latitude, double longitude}) {
    final locationImage = LocationHelper.getLocationImage(
      latitude: latitude,
      longitude: longitude,
    );

    setState(() {
      _previewImageUrl = locationImage;
    });
  }

  Future<void> _getCurrentLocation() async {
    final currentLocation = await Location().getLocation();

    _setPreviewImage(
      latitude: currentLocation.latitude,
      longitude: currentLocation.longitude,
    );
    _onSelectLocation(
      latitude: currentLocation.latitude,
      longitude: currentLocation.longitude,
    );
  }

  Future<void> _selectLocation() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (_) => MapScreen(
          isSelectMode: true,
        ),
      ),
    );

    if (selectedLocation == null) return;

    _setPreviewImage(
      latitude: selectedLocation.latitude,
      longitude: selectedLocation.longitude,
    );

    _onSelectLocation(
      latitude: selectedLocation.latitude,
      longitude: selectedLocation.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              : Stack(
                  children: [
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                    FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: _previewImageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  ],
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
              onPressed: _selectLocation,
            ),
          ],
        )
      ],
    );
  }
}
