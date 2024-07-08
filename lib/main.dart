import 'package:flutter/material.dart';
import 'package:travelling_app/app_data.dart';
import 'package:travelling_app/models/trip.dart';
import 'package:travelling_app/screens/categories_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travelling_app/screens/category_trips_screen.dart';
import 'package:travelling_app/screens/filters_screen.dart';
import 'package:travelling_app/screens/tabs_screen.dart';
import 'package:travelling_app/screens/trip_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'summer': false,
    'winter': false,
    'family': false,
  };

  List<Trip> _availableTrips = Trips_data;
  List<Trip> _favoriteTrips = [];

  void _changeFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableTrips = Trips_data.where((trip) {
        if (_filters['summer'] == true && trip.isInSummer != true) {
          return false;
        }
        if (_filters['winter'] == true && trip.isInWinter != true) {
          return false;
        }
        if (_filters['family'] == true && trip.isForFamilies != true) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _manageFavorite(String tripId) {
    final existingIndex =
        _favoriteTrips.indexWhere((trip) => trip.id == tripId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteTrips.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteTrips.add(Trips_data.firstWhere((trip) => trip.id == tripId));
      });
    }
  }

  bool _isFovarite(String id) {
    return _favoriteTrips.any((trip) => trip.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      theme: ThemeData(
          primaryColor: Colors.blue,
          primarySwatch: Colors.blue,
          hintColor: Colors.amber,
          fontFamily: 'ElMessiri',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline5: TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontFamily: 'ElMessiri',
                fontWeight: FontWeight.bold,
              ),
              headline6: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontFamily: 'ElMessiri',
                fontWeight: FontWeight.bold,
              ))),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("ar"), // Arabic
        const Locale("en"), // English (fallback)
      ],
      locale: const Locale('ar'), // Set Arabic as the default locale
      // Set text direction to RTL
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },

      routes: {
        '/': (ctx) => TabsScreen(
              favoriteTrips: _favoriteTrips,
            ),
        CategoryTripsScreen.screenRouter: (ctx) => CategoryTripsScreen(
              availableTrips: _availableTrips,
            ),
        TripDetailScreen.screenRoute: (ctx) => TripDetailScreen(
              manageFavorite: _manageFavorite,
              isFavorite: _isFovarite,
            ),
        FiltersScreen.screenRoute: (ctx) => FiltersScreen(
              saveFilters: _changeFilters,
              currentFilters: _filters,
            ),
      },
    );
  }
}
