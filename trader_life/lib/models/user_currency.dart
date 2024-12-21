class UserCurrency {
  final String currencyName;
  double amount;
  double productionRatePerSecond;

  UserCurrency({
    required this.currencyName,
    required this.amount,
    required this.productionRatePerSecond,
  });

  void updateAmount(double newAmount) {
    amount = newAmount;
  }

  void updateProductionRate(double newRate) {
    productionRatePerSecond = newRate;
  }
}
