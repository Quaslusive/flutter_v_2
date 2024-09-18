import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text("Homepage")),

        drawer: Drawer(
          backgroundColor: Colors.deepOrangeAccent[100],
          child: Column(
            children: [
              DrawerHeader(
                  child: Image.asset (
                 "lib/assets/images/icon1.png",
                  width: 50,
                  height: 50,

          ),
              ),

              ListTile(
                leading: const Icon(Icons.home),
                title: const Text ("Home"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/homepage");


                },
              ),
              ListTile(
                leading: const Icon(Icons.dangerous),
                title: const Text ("Blank Page"),
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
              width: 200,
              height: 200,
            ),
          ),


          const Spacer(),

          // Centered button
          Center(
            child: ElevatedButton(
              child: const Text("Gå till blankpage"),
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