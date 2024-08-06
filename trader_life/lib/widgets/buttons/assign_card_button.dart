import 'package:flutter/material.dart';
import 'package:trader_life/models/model_graphic_card.dart';
import 'package:trader_life/widgets/configured_text.dart';

class AssignCardButton extends StatelessWidget {
  final List<AssignedValue> listCoins;
  final String text;
  final Function(AssignedValue?, int) onChanged; // Updated callback signature
  final AssignedValue currentValue;
  final int id; // Add id parameter

  const AssignCardButton({
    super.key,
    required this.text,
    required this.onChanged,
    required this.listCoins,
    required this.currentValue,
    required this.id, // Initialize id
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<AssignedValue>(
      value: currentValue,
      style: const TextStyle(color: Colors.black), // Text color for selected item
      underline: Container(), // Remove the default underline
      items: listCoins.map((AssignedValue value) {
        return DropdownMenuItem<AssignedValue>(
          value: value,
          child: Container(
            padding:
               const EdgeInsets.symmetric(vertical: 8.0), // Padding around the text
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors
                      .grey.shade300, // Color of the line between menu items
                  width: 1.0, // Width of the line
                ),
              ),
            ),
            child: ConfiguredText(
              text: value.toString().split('.').last,
            ),
          ),
        );
      }).toList(),
      onChanged: (AssignedValue? newValue) {
        if (newValue != null) {
          onChanged(newValue, id); // Pass both newValue and id
        }
      },
      dropdownColor: const Color.fromARGB(255, 33,33,33), // Background color of the dropdown menu
    );
  }
}