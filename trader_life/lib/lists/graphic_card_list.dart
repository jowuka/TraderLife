import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trader_life/models/model_graphic_card.dart';
import 'package:trader_life/models/user_model.dart';
import 'package:trader_life/utility/shared_preferences.dart';
import 'package:trader_life/utility/timer_mining.dart';
import 'package:trader_life/widgets/buttons/assign_card_button.dart';
import 'package:trader_life/widgets/buttons/mining_buy_button.dart';
import 'package:trader_life/widgets/configured_text.dart';

class GraphicCardList extends StatefulWidget {
  final GraphicCard graphicCard;

  const GraphicCardList({super.key, required this.graphicCard});

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

Future<void> _onAssignedValueChanged(AssignedValue? newValue, int id) async {
  if (newValue != null) {
    setState(() {
      _currentAssignedValue = newValue;
    });
    await SharedPreferencesUtil.setAssignedValue(id, newValue.toString().split(".").last);

    // Timer'ı güncelle
    TimerService().notifyEvent();
  }
}

  Future<void> checkUserGraphicCard() async {
    bool hasCard = await SharedPreferencesUtil.userHasGraphicCard(widget.graphicCard.id);
    setState(() {
      userHasGraphicCard = hasCard;
    });
  }

  void addGraphicCard(UserModel userModel) {
    if (userModel.spendCash(widget.graphicCard.price)) {
      SharedPreferencesUtil.addUserGraphicCard(widget.graphicCard.id);
      checkUserGraphicCard();

      setState(() {
        widget.graphicCard.userAmount += 1; // userAmount değerini güncelle
      });
    } else {
      setState(() {
        userModel.addCash(150000000000000);
      });
    }
  }

  int calculatedHashRate() {
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        return SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(widget.graphicCard.imageURL, height: 45, width: 45),
              ConfiguredText(text: widget.graphicCard.model),
              ConfiguredText(text: "Units :${widget.graphicCard.userAmount.toString()}x"),
              ConfiguredText(
                text: 'Power: ${widget.graphicCard.power}W\nHash Rate: $_calculatedValue',
              ),
              Column(
                children: [
                  ConfiguredText(text: "Price: ${widget.graphicCard.price.toString()}\$"),
                  MiningBuyButton(onPressed: () => addGraphicCard(userModel)),
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
                          id: widget.graphicCard.id,
                        ),
                      ]
                    : [
                        const Icon(Icons.lock),
                      ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
