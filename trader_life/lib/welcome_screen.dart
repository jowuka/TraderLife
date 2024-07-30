import 'package:flutter/material.dart';
import 'package:trader_life/main_game.dart';
import 'package:trader_life/utility/shared_preferences.dart';

const welcomeText = "Satoshi Nakamato published the bitcoin, our journey to the moon has begun... \n\n\n\n\n\t\t\t\t\t\t\t\t\t\t\t09 January 2009";

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferencesUtil.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator(color: Colors.white)),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Game()),
              );
            },
            child: const Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 32),
                  child:  Text(
                    welcomeText,
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: Text("Error initializing shared preferences", style: TextStyle(color: Colors.white))),
          );
        }
      },
    );
  }
}
