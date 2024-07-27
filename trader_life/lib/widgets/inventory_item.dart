import 'package:device_screen_size/device_screen_size.dart';
import 'package:flutter/material.dart';
import 'package:trader_life/data/data_graphic_card.dart';
import 'package:trader_life/widgets/graphic_card_list.dart';

class InventoryItemWidget extends StatelessWidget {
  const InventoryItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double listViewHeight = DeviceScreenSize.screenHeightInPercentage(context, percentage: 0.5); 

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: SizedBox(
        height: listViewHeight,
        child: ListView.separated(
          itemCount: GraphicCardData.graphicCards.values.length,
          itemBuilder: (context, index) {
            final graphicCard = GraphicCardData.graphicCards.values.elementAt(index);
            return GraphicCardList(graphicCard: graphicCard);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10), 
        ),
      ),
    );
  }
}
