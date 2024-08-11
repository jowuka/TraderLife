import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader_life/models/user_model.dart';
import 'package:trader_life/utility/shared_preferences.dart';
import 'package:trader_life/widgets/configured_text.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});
  @override
  State<StatefulWidget> createState() => _TopBar();
}

class _TopBar extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 15,
      color: Colors.red,
      child: Row(
        children: [
          ConfiguredText(text: '${UserModel.userCash}'),
          const SizedBox(
            width: 50,
          ),
          ConfiguredText(text: '${UserModel.userLevel}'),
        ],
      ),
    );
  }
}