import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text("Hemsida")),

        drawer: Drawer(
          backgroundColor: Colors.deepOrangeAccent[100],
          child: Column(
            children: [
              DrawerHeader(
                  child: Image.asset (
                 "lib/assets/images/icon/icon1.png",
                  width: 100,
                  height: 100,

          ),
              ),

              ListTile(
                leading: const Icon(Icons.home),
                title: const Text ("Home"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/homesida");


                },
              ),
              ListTile(
                leading: const Icon(Icons.rocket),
                title: const Text ("Asteroid Sida"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/asteroid_page");

                },
              ),
            ],
          ),
        ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              'lib/assets/images/PsBattle_This_orange_cat.jpeg',
              width: 500,
              height: 500,
            ),
          ),


          const Spacer(),

          // Centered button
          Center(
            child: ElevatedButton(
              child: const Text("Gå till Asteroid sidan"),
              onPressed: () {
                Navigator.pushNamed(context, "/asteroid_page");
              },
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}