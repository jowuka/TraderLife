import 'package:flutter/material.dart';
import 'package:trader_life/models/user_model.dart';
import 'package:trader_life/widgets/buttons/mine_button.dart';
import 'package:trader_life/widgets/menu/mining_menu.dart';
import 'package:trader_life/widgets/menu/wallet_menu.dart';
import 'package:trader_life/widgets/top_bar.dart';

const String _miningButtonImagePath = "assets/images/miningbutton.png";
const String _walletButtonImagePath = "assets/images/walletbutton.png";
const String _workButtonImagePath = "assets/images/workbutton.png";
const String _backgroundImagePath = "assets/images/background.webp";

class Game extends StatefulWidget {
  const Game({super.key, required this.user});
  final UserModel user;

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {

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
                  menuReturn: InventoryDialog(),
                ),
                SizedBox(height: 16),
                MineButton(
                  imagePath: _walletButtonImagePath,
                  menuReturn: InventoryDialog(),
                ),
              ],
            ),
          ),
          TopBar(user: widget.user),
        ],
      ),
    );
  }
}
