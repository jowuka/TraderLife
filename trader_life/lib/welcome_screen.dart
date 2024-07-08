import 'package:flutter/material.dart';
import 'package:trader_life/main_game.dart';

const WelcomeText = "Satoshi Nakamato published the bitcoin, our journey to the moon has begun... \n\n\n\n\n\t\t\t\t\t\t\t\t\t\t\t09 January 2009";

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => const Game())  );
          },
          child: const Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                    style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 20), WelcomeText),
            ),
          ),
    );
  }
}
