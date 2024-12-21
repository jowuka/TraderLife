import 'dart:collection';
import 'package:trader_life/models/currency_model.dart';
import 'package:trader_life/utility/shared_preferences.dart';

class CoinData {
  static final SharedPreferencesUtil _prefs = SharedPreferencesUtil();
  
  static final HashMap<String, Coin> coins = HashMap.from({
    'BTC': Coin(
      id: 0,
      name: 'Bitcoin',
      symbol: 'BTC',
      imageURL: "assets/images/coins/bitcoin.png",
      currentPrice: 65000,
      userBalance: _prefs.getUserCoinBalance('userBTC'),
    ),
    'ETH': Coin(
      id: 1,
      name: 'Ethereum',
      symbol: 'ETH',
      imageURL: "assets/images/coins/ethereum.png",
      currentPrice: 3000,
      userBalance: _prefs.getUserCoinBalance('userETH'),
    ),
    'SOL': Coin(
      id: 2,
      name: 'Solana',
      symbol: 'SOL',
      imageURL: "assets/images/coins/solana.png",
      currentPrice: 200,
      userBalance: _prefs.getUserCoinBalance('userSOL'),
    ),
    'USD': Coin(
      id: 3,
      name: 'USD',
      symbol: 'USD',
      imageURL: "assets/images/coins/solana.png",
      currentPrice: 1,
      userBalance: _prefs.getUserCoinBalance('userCash'),
    ),
  });

  // Yeni eklenen metod
  static void updatePrices(Map<String, double> newPrices) {
    newPrices.forEach((symbol, price) {
      if (coins.containsKey(symbol)) {
        coins[symbol]!.updatePrice(price);
      }
    });
  }
}