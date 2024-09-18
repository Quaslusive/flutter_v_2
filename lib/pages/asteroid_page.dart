import 'package:flutter/material.dart';
import 'package:flutter_v_2/model/asteroid.dart';
import 'package:flutter_v_2/nasa_api_service.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the package for URL launch

class AsteroidPage extends StatefulWidget {
  const AsteroidPage({super.key});

  @override
  _AsteroidPageState createState() => _AsteroidPageState();
}

class _AsteroidPageState extends State<AsteroidPage> {
  late Future<List<Asteroid>> futureAsteroids;
  final NasaApiService nasaApiService = NasaApiService();

  @override
  void initState() {
    super.initState();
    // Fetch data for today
    futureAsteroids = nasaApiService.fetchAsteroidsToday('2024-09-01', '2024-09-07');
  }


  // Function to launch the JPL URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Opps $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(' Lista över Asteroider som ligger nära Jorden')),
      body: Center(
        child: FutureBuilder<List<Asteroid>>(
          future: futureAsteroids,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final asteroids = snapshot.data!;

              if (asteroids.isEmpty) {
                return const Text('Något gick snett med NASA:s API.');
              }

              return ListView.builder(
                itemCount: asteroids.length,
                itemBuilder: (context, index) {
                  final asteroid = asteroids[index];
                  return ListTile(
                    title: Text(asteroid.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('.Est Diameter: ${asteroid.estimatedDiameter.toStringAsFixed(2)} km'),
                        Text('Absolut Magnitud: ${asteroid.absoluteMagnitude}'),
                        Text('Relativ hastighet: ${asteroid.relativeVelocity.toStringAsFixed(2)} km/h'),
                        Text('Miss Distance: ${asteroid.asteroidDistance.toStringAsFixed(2)} km'),
                        Text('Date: ${asteroid.asteroidDate}'),
                      ],
                    ),
                    trailing: asteroid.isHazardous
                        ? const Icon(Icons.warning, color: Colors.red)
                        : const Icon(Icons.check, color: Colors.green),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(asteroid.name),
                            content: Text('Vill du see Orbit View?'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _launchURL(asteroid.nasaJplUrl);
                                },
                                child: const Text('Orbit View'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              );
            } else {
              return const Text('Ej data.');
            }
          },
        ),
      ),
    );
  }
}
