import 'dart:convert';
import 'package:flutter_v_2/model/asteroid.dart';
import 'package:http/http.dart' as http;

class NasaApiService {
  final String apiKey =
      'V8rm0v9dfXt821mwqXI26TMeRn0x2hFlX970nmY2';

// har försökt att använda "today" endpont men får
// "Error: TypeError: null: type "Null" is not a subtype of a type"List<dynamic>"

/*  Future<List<Asteroid>> fetchAsteroidsToday() async {
    final url =
        'https://api.nasa.gov/neo/rest/v1/feed?today&api_key=$apiKey';
    final response = await http.get(Uri.parse(url));*/

  Future<List<Asteroid>> fetchAsteroidsToday(
      String startDate, String endDate) async {
    final url =
        'https://api.nasa.gov/neo/rest/v1/feed?start_date=$startDate&end_date=$endDate&api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['near_earth_objects'] != null) {
        final List<dynamic> nearEarthObjects =
            data['near_earth_objects'][startDate];
/*
            data['near_earth_objects'][data.keys.first];
*/

        if (nearEarthObjects.isNotEmpty) {
          return nearEarthObjects
              .map((json) => Asteroid.fromJson(json))
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Det fanns inga astrodier nära Jorden idag.');
      }
    } else {
      throw Exception(
          'Det gick inte att ladda asteroider. Statuskod: ${response.statusCode}');
    }
  }
}
