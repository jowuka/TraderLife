import 'package:flutter/material.dart';
import 'package:trader_life/widgets/buttons/mine_button.dart';
import 'package:trader_life/widgets/mining_menu.dart';

const String _miningButtonImagePath = "assets/images/miningbutton.png";
const String _walletButtonImagePath = "assets/images/walletbutton.png";
const String _workButtonImagePath = "assets/images/workbutton.png";
const String _backgroundImagePath = "assets/images/background.webp";

class Game extends StatefulWidget {
  const Game({super.key});
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_backgroundImagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MineButton(
                imagePath: _miningButtonImagePath,
                menuReturn: MiningMenu(),
              ),
              SizedBox(height: 16),
              MineButton(
                imagePath: _workButtonImagePath,
                // You can pass another widget or null here
                menuReturn: null,
              ),
              SizedBox(height: 16),
              MineButton(
                imagePath: _walletButtonImagePath,
                // You can pass another widget or null here
                menuReturn: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
