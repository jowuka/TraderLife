import 'package:flutter/material.dart';
import 'package:device_screen_size/device_screen_size.dart';
import 'package:trader_life/widgets/graphic_card_item.dart';

class MiningMenu extends StatelessWidget {
  const MiningMenu({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = DeviceScreenSize.screenHeightInPercentage(context, percentage: 0.83);
    double screenWidth = DeviceScreenSize.screenWidthInPercentage(context, percentage: 0.84);
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: const Color.fromARGB(255,33, 33,33),
        ),
        padding: const EdgeInsets.all(16.0),
        height: screenHeight,
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: const Color.fromARGB(255, 104,104,104),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    const Text(
                      'Mining',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const GraphicCardItem(),
          ],
        ),
      ),
    );
  }
}
