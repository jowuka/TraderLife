import 'package:flutter/material.dart';
import 'package:trader_life/models/user_model.dart';
import 'package:trader_life/utility/shared_preferences.dart';
import 'package:trader_life/widgets/buttons/mine_button.dart';
import 'package:trader_life/widgets/menu/mining_menu.dart';
import 'package:trader_life/widgets/top_bar.dart';

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
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    UserModel userData = await SharedPreferencesUtil.getUserData();
    setState(() {
      user = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(_backgroundImagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16),
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
          if (user != null) TopBar(user: user!),
        ],
      ),
    );
  }
}
