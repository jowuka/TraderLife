import 'package:device_screen_size/device_screen_size.dart';
import 'package:flutter/material.dart';

class WorkButton extends StatelessWidget {
  const WorkButton({
    super.key,
    required this.onPressed,
    this.isWorking = false,
  });

  final VoidCallback onPressed;
  final bool isWorking;

  @override
  Widget build(BuildContext context) {
    double buttonHeight = DeviceScreenSize.screenHeightInPercentage(context, percentage: 0.13);
    double buttonWidth = DeviceScreenSize.screenWidthInPercentage(context, percentage: 0.13);

    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: GestureDetector(
        onTap: isWorking ? null : onPressed,
        child:  Image.asset(
          "assets/images/buybutton.png"
        ), // Disable tap if work is in progress
      ),
    );
  }
}