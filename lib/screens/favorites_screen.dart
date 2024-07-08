// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:travelling_app/models/trip.dart';
import 'package:travelling_app/widgets/trip_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen(
    this.favoriteTrips,
  );

  final List<Trip> favoriteTrips;

  @override
  Widget build(BuildContext context) {
    if (favoriteTrips.isEmpty) {
      return Center(
        child: Text('ليس لديك أي رحلة في قائمة المفضلة '),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return TripItem(
            title: favoriteTrips[index].title,
            imageUrl: favoriteTrips[index].imageUrl,
            duration: favoriteTrips[index].duration,
            tripType: favoriteTrips[index].tripType,
            season: favoriteTrips[index].season,
            id: favoriteTrips[index].id,
          );
        },
        itemCount: favoriteTrips.length,
      );
    }
  }
}
