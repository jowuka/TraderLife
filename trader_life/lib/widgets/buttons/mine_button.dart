import 'package:device_screen_size/device_screen_size.dart';
import 'package:flutter/material.dart';

class MineButton extends StatelessWidget {
  const MineButton({
    super.key,
    required this.imagePath,
    this.menuReturn,
  });

  final Widget? menuReturn;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    double buttonHeight = DeviceScreenSize.screenHeightInPercentage(context, percentage: 0.13);
    double buttonWidth = DeviceScreenSize.screenWidthInPercentage(context, percentage: 0.13);

    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: GestureDetector(
        child: Image.asset(imagePath),
        onTap: () {
          if (menuReturn != null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return menuReturn!;
              },
            );
          }
        },
      ),
    );
  }
}