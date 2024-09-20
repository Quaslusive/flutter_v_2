import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_v_2/pages/asteroid_page.dart';
import 'package:flutter_v_2/pages/homepage.dart';

 Future <void> main() async {
 /* await dotenv.load();*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        "/homepage": (context) => const HomePage(),
        "/asteroid_page": (context) => const AsteroidPage()

      },

    );

  }
}
