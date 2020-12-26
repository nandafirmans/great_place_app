import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:great_place_app/models/place.dart';
import 'package:latlong/latlong.dart';

class MapScreen extends StatefulWidget {
  static String routeName = '/map';
  final PlaceLocation initialLocation;
  final bool isSelectMode;

  const MapScreen({
    Key key,
    this.initialLocation = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
    ),
    this.isSelectMode = false,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _selectedLocation;

  @override
  void initState() {
    if (!widget.isSelectMode) {
      _selectedLocation = LatLng(
        widget.initialLocation.latitude,
        widget.initialLocation.longitude,
      );
    }
    super.initState();
  }

  void _selectLocation(LatLng latLng) {
    setState(() {
      _selectedLocation = latLng;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
        actions: [
          if (widget.isSelectMode)
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _selectedLocation != null
                  ? () => Navigator.of(context).pop(_selectedLocation)
                  : null,
            )
        ],
      ),
      body: Container(
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(
              widget.initialLocation.latitude,
              widget.initialLocation.longitude,
            ),
            zoom: 16,
            onTap: widget.isSelectMode ? _selectLocation : null,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            if (_selectedLocation != null)
              MarkerLayerOptions(
                markers: [
                  Marker(
                    height: 80,
                    width: 80,
                    point: _selectedLocation,
                    builder: (ctx) => Container(
                      child: Icon(
                        Icons.location_pin,
                        color: Theme.of(context).errorColor,
                        size: 42,
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
