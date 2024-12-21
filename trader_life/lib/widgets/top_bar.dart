import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trader_life/models/user_model.dart';
import 'package:trader_life/utility/timer_mining.dart';
import 'configured_text.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    // UserModel'i Consumer ile dinliyoruz
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        // TimerService'ten gelen coin üretim verisini dinlemek için StreamBuilder kullanıyoruz
        return StreamBuilder<Map<String, double>>(
          stream: TimerService().coinStream, // Stream'i dinle
          builder: (context, snapshot) {

            // Veri geldiğinde, snapshot.data üzerinden coin bilgilerine ulaşabilirsin
            Map<String, double>? coinData = snapshot.data;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 25,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Kullanıcı seviyesi ve nakit bilgisi
                  Row(
                    children: [
                      ConfiguredText(
                        text: 'Level: ${userModel.userLevel}',
                      ),
                      const SizedBox(width: 20),
                      ConfiguredText(
                        text: 'Cash: ${userModel.userCash.toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                  // Coin bilgileri
                  Row(
                    children: coinData?.entries.map(
                      (coin) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ConfiguredText(
                            text: '${coin.key}: ${coin.value.toStringAsFixed(10)}/s',
                          ),
                        );
                      },
                    ).toList() ?? [],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
