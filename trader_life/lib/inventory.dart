import 'package:flutter/material.dart';
import 'package:trader_life/helper.dart';


class InventoryDialog extends StatelessWidget {
  const InventoryDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(

      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: heightInventory,
        width: widthInventory,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 20, // Number of inventory items
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
