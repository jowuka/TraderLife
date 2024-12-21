import 'package:device_screen_size/device_screen_size.dart';
import 'package:flutter/material.dart';
import 'package:trader_life/data/data_graphic_card.dart';
import 'package:trader_life/models/model_graphic_card.dart';
import 'package:trader_life/lists/graphic_card_list.dart';

class GraphicCardItem extends StatelessWidget {
  const GraphicCardItem({super.key});

  @override
  Widget build(BuildContext context) {
    double listViewHeight = DeviceScreenSize.screenHeightInPercentage(context, percentage: 0.64);

    List<GraphicCard> sortedGraphicCards = GraphicCardData.graphicCards.values.toList()
      ..sort((a, b) => a.id.compareTo(b.id));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: SizedBox(
        height: listViewHeight,
        child: ListView.separated(
          itemCount: sortedGraphicCards.length,
          itemBuilder: (context, index) {
            final graphicCard = sortedGraphicCards[index];
            return GraphicCardList(graphicCard: graphicCard);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        ),
      ),
    );
  }
}