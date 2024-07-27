import 'package:flutter/material.dart';
import 'package:trader_life/models/model_graphic_card.dart';

class GraphicCardList extends StatefulWidget {
  final GraphicCard graphicCard;

  const GraphicCardList({Key? key, required this.graphicCard})
      : super(key: key);

  @override
  _GraphicCardListState createState() => _GraphicCardListState();
}

class _GraphicCardListState extends State<GraphicCardList> {
  double _calculatedValue = 0.0;

  @override
  void initState() {
    super.initState();
    _performCalculations();
  }

  void _performCalculations() {
    // Example calculation based on graphicCard properties
    setState(() {
      _calculatedValue +=
          widget.graphicCard.power * 1.5; // Just an example calculation
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Image.asset(widget.graphicCard.imageURL, height: 50, width: 50),
      Text(
        style: const TextStyle(color: const Color.fromARGB(255, 61, 61, 61),
        fontWeight: FontWeight.bold
        ),
        widget.graphicCard.model),
      Text(
        style: const TextStyle(color: const Color.fromARGB(255, 61, 61, 61),
        fontWeight: FontWeight.bold
        ),
          'Power: ${widget.graphicCard.power}W\nCalculated Value: $_calculatedValue'),
      TextButton(
          onPressed: () {
            _performCalculations();
          },
          child: const Text("Assign"))
    ]);
  }
}
