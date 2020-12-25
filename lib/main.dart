import 'package:flutter/material.dart';
import 'package:great_place_app/providers/places_provider.dart';
import 'package:great_place_app/screens/add_place_screen.dart';
import 'package:great_place_app/screens/place_detail_screen.dart';
import 'package:great_place_app/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PlacesProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Great Place App',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: PlacesListScreen.routeName,
        routes: {
          AddPlaceScreen.routeName: (_) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (_) => PlaceDetailScreen(),
          PlacesListScreen.routeName: (_) => PlacesListScreen(),
        },
      ),
    );
  }
}
