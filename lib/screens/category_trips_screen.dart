// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:travelling_app/models/trip.dart';
import 'package:travelling_app/widgets/trip_item.dart';

class CategoryTripsScreen extends StatefulWidget {
  static const screenRouter = '/categroy-trips';
  final List<Trip> availableTrips;
  const CategoryTripsScreen({
    Key? key,
    required this.availableTrips,
  }) : super(key: key);

  @override
  State<CategoryTripsScreen> createState() => _CategoryTripsScreenState();
}

class _CategoryTripsScreenState extends State<CategoryTripsScreen> {
  late String categoryTitle;
  late List<Trip> displayTrip;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final routeArgument =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryId = routeArgument['id'];
    categoryTitle = routeArgument['title']!;
    displayTrip = widget.availableTrips.where((trip) {
      return trip.categories.contains(categoryId);
    }).toList();
  }

  void _removeTrip(String tripId) {
    setState(() {
      displayTrip.removeWhere((trip) => trip.id == tripId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return TripItem(
              title: displayTrip[index].title,
              imageUrl: displayTrip[index].imageUrl,
              duration: displayTrip[index].duration,
              tripType: displayTrip[index].tripType,
              season: displayTrip[index].season,
              id: displayTrip[index].id,
            );
          },
          itemCount: displayTrip.length,
        ));
  }
}
