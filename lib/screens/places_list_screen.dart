import 'package:flutter/material.dart';
import 'package:great_place_app/providers/places_provider.dart';
import 'package:great_place_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  static String routeName = '/place_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Place'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<PlacesProvider>(
                  child: Center(
                    child: const Text('No saved places yet..'),
                  ),
                  builder: (context, value, child) => value.items.length > 0
                      ? ListView.builder(
                          itemCount: value.items.length,
                          itemBuilder: (context, i) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(value.items[i].image),
                            ),
                            title: Text(value.items[i].title),
                            onTap: () {},
                          ),
                        )
                      : child,
                );
        },
      ),
    );
  }
}
