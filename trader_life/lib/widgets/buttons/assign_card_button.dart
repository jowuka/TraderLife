import 'package:flutter/material.dart';
import 'package:trader_life/models/model_graphic_card.dart';

class AssignCardButton extends StatelessWidget {
  final List<AssignedValue> listCoins;
  final bool isAssign;
  final String text;
  final Function(AssignedValue?) onChanged;
  final AssignedValue currentValue;

  const AssignCardButton({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.isAssign,
    required this.listCoins,
    required this.currentValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<AssignedValue>(
      value: currentValue,
      items: listCoins.map((AssignedValue value) {
        return DropdownMenuItem<AssignedValue>(
          value: value,
          child: Text(value.toString().split('.').last),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
