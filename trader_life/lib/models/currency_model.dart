class Coin {
  final int id;
  final String name;
  final String symbol;
  final String imageURL;
  double currentPrice;
  double userBalance;

  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.imageURL,
    required this.currentPrice,
    required this.userBalance,
  });

  void updateBalance(double amount) {
    userBalance = amount;  // Direkt olarak yeni değeri atıyoruz
  }

  void updatePrice(double newPrice) {
    currentPrice = newPrice;
  }
}