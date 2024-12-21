import 'dart:collection';

class UserWallet {
  final HashMap<String, UserCurrency> currencies = HashMap<String, UserCurrency>();
  static const List<String> initialCoins = ['BTC', 'ETH', 'SOL'];

  UserWallet() {
    for (var coin in initialCoins) {
      currencies[coin] = UserCurrency(currencyName: coin, amount: 0.0, productionRatePerSecond: 0.0);
    }
  }

  void updateCurrency(String currencyName, double amount) {
    if (currencies.containsKey(currencyName)) {
      currencies[currencyName]?.updateAmount(amount);
    } else {
      currencies[currencyName] = UserCurrency(currencyName: currencyName, amount: amount, productionRatePerSecond: 0.0);
    }
  }

  void updateProductionRate(String currencyName, double rate) {
    if (currencies.containsKey(currencyName)) {
      currencies[currencyName]?.updateProductionRate(rate);
    } else {
      currencies[currencyName] = UserCurrency(currencyName: currencyName, amount: 0.0, productionRatePerSecond: rate);
    }
  }

  double getCurrencyAmount(String currencyName) {
    return currencies[currencyName]?.amount ?? 0.0;
  }

  double getProductionRate(String currencyName) {
    return currencies[currencyName]?.productionRatePerSecond ?? 0.0;
  }
}

class UserCurrency {
  final String currencyName;
  double amount;
  double productionRatePerSecond;

  UserCurrency({required this.currencyName, required this.amount, required this.productionRatePerSecond});

  void updateAmount(double newAmount) {
    amount = newAmount;
  }

  void updateProductionRate(double newRate) {
    productionRatePerSecond = newRate;
  }
}
