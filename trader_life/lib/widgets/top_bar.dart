import 'package:flutter/material.dart';
import 'package:trader_life/widgets/configured_text.dart';
import 'package:trader_life/models/user_model.dart';

class TopBar extends StatelessWidget {
  final UserModel user;
  
  const TopBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    double experiencePercentage = (user.userExperience % 100) / 100;

    return Column(
      children: [
        Container(
          color: const Color.fromARGB(255, 33, 33, 33),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey[800],
                child: Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * experiencePercentage,
                      height: 2,
                    ),
                  ],
                ),
              ),
              const ConfiguredText(text: "Something Here"),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
