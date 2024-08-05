import 'package:flutter/material.dart';
import 'package:trader_life/widgets/configured_text.dart';
import 'package:trader_life/models/user_model.dart';

class TopBar extends StatefulWidget {
  final UserModel user;

  const TopBar({super.key, required this.user});

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {


  void _updateExperience() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double experiencePercentage = (widget.user.userExperience % 100) / 100;

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 20,
          color: Colors.grey[800],
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * experiencePercentage,
                height: 20,
                color: Colors.green, // Change the color to your preferred color
              ),
              Center(
                child: Text(
                  "${(experiencePercentage * 100).toInt()}%",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            ConfiguredText(text: "Level ${widget.user.userLevel}"),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
