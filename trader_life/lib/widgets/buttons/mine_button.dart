import 'package:flutter/material.dart';
import 'package:trader_life/helper.dart';
import 'package:trader_life/inventory.dart';

class MineButton extends StatelessWidget {
  const MineButton({super.key, required this.imagePath});

  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthLeftColumn,
      child: GestureDetector(
        child: Image.asset(imagePath),
        onTap: () {
             showDialog(
              context: context,
              builder: (BuildContext context) {
                return const InventoryDialog();
              },
            ); 
        },
      ),
    );
  }
}
