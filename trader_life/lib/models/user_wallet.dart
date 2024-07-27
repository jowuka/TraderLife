import 'dart:collection';

import 'package:trader_life/models/currency_model.dart';

class UserWallet {
  final HashMap<String, UserCurrency> currencies = HashMap<String, UserCurrency>();

  UserWallet() {
    // Initialize with some default currencies
    currencies['BTC'] = UserCurrency(currencyName: 'BTC', amount: 0.0);
    currencies['ETH'] = UserCurrency(currencyName: 'ETH', amount: 0.0);
    // Add more currencies as needed
  }

  void updateCurrency(String currencyName, double amount) {
    if (currencies.containsKey(currencyName)) {
      currencies[currencyName]!.amount += amount;
    } else {
      currencies[currencyName] = UserCurrency(currencyName: currencyName, amount: amount);
    }
  }

  UserCurrency? getCurrency(String currencyName) {
    return currencies[currencyName];
  }
}
