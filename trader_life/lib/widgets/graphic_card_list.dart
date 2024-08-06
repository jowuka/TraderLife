import 'package:flutter/material.dart';
import 'package:trader_life/models/model_graphic_card.dart';
import 'package:trader_life/utility/shared_preferences.dart';
import 'package:trader_life/widgets/buttons/assign_card_button.dart';
import 'package:trader_life/widgets/buttons/mining_buy_button.dart';
import 'package:trader_life/widgets/configured_text.dart';

class GraphicCardList extends StatefulWidget {
  final GraphicCard graphicCard;

  const GraphicCardList({Key? key, required this.graphicCard}) : super(key: key);

  @override
  _GraphicCardListState createState() => _GraphicCardListState();
}

class _GraphicCardListState extends State<GraphicCardList> {
  double _calculatedValue = 0.0;
  AssignedValue _currentAssignedValue = AssignedValue.NULL;
  bool userHasGraphicCard = false;

  @override
  void initState() {
    super.initState();
    _performCalculations();
    _loadAssignedValue();
    checkUserGraphicCard(); 
  }

  void _performCalculations() {
    setState(() {
      _calculatedValue += widget.graphicCard.power * 1.5;
    });
  }

  AssignedValue _convertStringToAssignedValue(String value) {
    try {
      return AssignedValue.values.firstWhere((e) => e.toString().split('.').last == value);
    } catch (e) {
      return AssignedValue.NULL;
    }
  }

  Future<void> _loadAssignedValue() async {
    String? assignedValueString = await SharedPreferencesUtil.getAssignedValue(widget.graphicCard.id);
    setState(() {
      _currentAssignedValue = assignedValueString != null
          ? _convertStringToAssignedValue(assignedValueString)
          : AssignedValue.NULL;
    });
  }

  void _onAssignedValueChanged(AssignedValue? newValue, int id) {
    if (newValue != null) {
      setState(() {
        _currentAssignedValue = newValue;
        SharedPreferencesUtil.setAssignedValue(id, newValue.toString().split(".").last);
      });
    }
  }

  Future<void> checkUserGraphicCard() async {
    bool hasCard = await SharedPreferencesUtil.userHasGraphicCard(widget.graphicCard.id);
    setState(() {
      userHasGraphicCard = hasCard;
    });
  }

  void addGraphicCard() {
    SharedPreferencesUtil.addUserGraphicCard(widget.graphicCard.id);
    checkUserGraphicCard();
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
            ConfiguredText(text: "Price: ${widget.graphicCard.price.toString()}"),
            MiningBuyButton(onPressed: addGraphicCard),
          ],
        ),
        SizedBox(
          width: 100, 
          child: Column(
            children: userHasGraphicCard
              ? [
                  const ConfiguredText(text: "Assign to"),
                  AssignCardButton(
                    text: "Assign",
                    onChanged: (newValue, id) => _onAssignedValueChanged(newValue, id),
                    listCoins: AssignedValue.values.toList(),
                    currentValue: _currentAssignedValue,
                    id: widget.graphicCard.id, // Pass the id
                  ),
                ]
              : [
                  const Icon(Icons.lock),
                ],
          ),
        ),
      ],
    );
  }
}