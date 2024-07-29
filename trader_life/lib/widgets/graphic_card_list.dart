import 'package:flutter/material.dart';
import 'package:trader_life/models/model_graphic_card.dart';
import 'package:trader_life/widgets/buttons/assign_card_button.dart';
import 'package:trader_life/widgets/configured_text.dart';

class GraphicCardList extends StatefulWidget {
  final GraphicCard graphicCard;

  const GraphicCardList({Key? key, required this.graphicCard}) : super(key: key);

  @override
  _GraphicCardListState createState() => _GraphicCardListState();
}

class _GraphicCardListState extends State<GraphicCardList> {
  double _calculatedValue = 0.0;
  late AssignedValue _currentAssignedValue;

  @override
  void initState() {
    super.initState();
    _performCalculations();
    _currentAssignedValue = _convertStringToAssignedValue(widget.graphicCard.assignedValue);
  }

  void _performCalculations() {
    setState(() {
      _calculatedValue += widget.graphicCard.power * 1.5; // Just an example calculation
    });
  }

  AssignedValue _convertStringToAssignedValue(String value) {
    try {
      return AssignedValue.values.firstWhere((e) => e.toString().split('.').last == value);
    } catch (e) {
      return AssignedValue.X; // Default to NULL if no match found
    }
  }

  void _onAssignedValueChanged(AssignedValue? newValue) {
    if (newValue != null) {
      setState(() {
        _currentAssignedValue = newValue;
        widget.graphicCard.assignedValue = newValue.toString().split('.').last; // Update the graphic card's assigned value
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(widget.graphicCard.imageURL, height: 50, width: 50),
        ConfiguredText(text: widget.graphicCard.model),
        ConfiguredText(
          text: 'Power: ${widget.graphicCard.power}W\nCalculated Value: $_calculatedValue',
        ),
        Column(
          children: [
            const ConfiguredText(text: "Assign to"),
            AssignCardButton(
              text: "Assign",
              onChanged: _onAssignedValueChanged,
              isAssign: widget.graphicCard.assignedValue == "NULL",
              listCoins: AssignedValue.values.toList(),
              currentValue: _currentAssignedValue,
            ),
          ],
        ),
      ],
    );
  }
}
