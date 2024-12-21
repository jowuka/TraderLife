import 'package:flutter/foundation.dart';
import 'package:trader_life/data/data_currency.dart';

class CoinPriceProvider with ChangeNotifier {
  void updatePrices() {
    // This method will be called by PriceUpdateService
    notifyListeners();
  }

  double get btcPrice => CoinData.coins['BTC']!.currentPrice;
  double get ethPrice => CoinData.coins['ETH']!.currentPrice;
  double get solPrice => CoinData.coins['SOL']!.currentPrice;
}