import 'package:flutter/material.dart';
import 'package:device_screen_size/device_screen_size.dart';

class MiningBuyButton extends StatelessWidget {
  const MiningBuyButton({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    double buttonHeight = DeviceScreenSize.screenHeightInPercentage(context, percentage: 0.07);
    double buttonWidth = DeviceScreenSize.screenWidthInPercentage(context, percentage: 0.088);
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Image.asset(
        "assets/images/buybutton.png",
        height: buttonHeight,
        width: buttonWidth,
      ),
    );
  }
}
