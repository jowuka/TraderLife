import 'package:flutter/material.dart';
import 'package:trader_life/inventory.dart';

class MineButton extends StatelessWidget {
  const MineButton({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 56,
      child: GestureDetector(
        child: Image.asset("assets/images/miningbutton.png"),
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
