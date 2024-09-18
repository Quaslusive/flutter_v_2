import 'dart:convert';
import 'package:flutter_v_2/model/asteroid.dart';
import 'package:http/http.dart' as http;

class NasaApiService {

final String apiKey = 'V8rm0v9dfXt821mwqXI26TMeRn0x2hFlX970nmY2'; // Replace with your NASA API key

// Update to use the '/feed/today' endpoint
Future<List<Asteroid>> fetchAsteroidsToday(String startDate, String endDate) async {
  final url = 'https://api.nasa.gov/neo/rest/v1/feed?start_date=$startDate&end_date=$endDate&api_key=$apiKey';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<dynamic> nearEarthObjects = data['near_earth_objects'][startDate];
    return nearEarthObjects.map((json) => Asteroid.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load asteroids');
  }
}
}