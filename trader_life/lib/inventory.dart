import 'package:device_screen_size/device_screen_size.dart';
import 'package:flutter/material.dart';
import 'package:trader_life/helper.dart';


class InventoryDialog extends StatelessWidget {
  const InventoryDialog({super.key});


  @override
  Widget build(BuildContext context) {
      double screenHeight = DeviceScreenSize.screenHeightInPercentage(context,
                  percentage: 0.7);                                                         // Screen Width & Height They should be change on IOS & WINDOWS & CHROME
      double screenWidth = DeviceScreenSize.screenWidthInPercentage(context,
                  percentage: 0.7);
    return Dialog(

      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: const Color.fromARGB(255, 157,165,189)),
        
        padding: const EdgeInsets.all(16.0),
          height: screenHeight,
          width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: const Color.fromARGB(255, 58,76,122)),
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
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 15,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 10,                    // Number of inventory items
                itemBuilder: (context, index) {
                  return InventoryItem(index: index);
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

class InventoryItem extends StatelessWidget {
  final int index;

  const InventoryItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text('Item $index'),
      ),
    );
  }
}
