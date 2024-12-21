import 'dart:async';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader_life/data/data_currency.dart';
import 'package:trader_life/data/data_graphic_card.dart';
import 'package:trader_life/models/user_model.dart';
  final btcPrice = CoinData.coins['BTC']?.currentPrice;
  final ethPrice = CoinData.coins['ETH']?.currentPrice;
  final solPrice = CoinData.coins['SOL']?.currentPrice;
  Random random = Random();
UserModel user = UserModel();

class TimerService {
  TimerService._privateConstructor();
  static final TimerService _instance = TimerService._privateConstructor();
  factory TimerService() => _instance;

  Timer? _timer;
  
  // Toplam coin miktarlarını dinleyecek StreamController
  final StreamController<Map<String, double>> _coinStreamController = StreamController<Map<String, double>>.broadcast();
  final StreamController<Map<String, double>> _totalCoinStreamController = StreamController<Map<String, double>>.broadcast();
  
  Stream<Map<String, double>> get coinStream => _coinStreamController.stream;
  Stream<Map<String, double>> get totalCoinStream => _totalCoinStreamController.stream; // Toplam coinleri dinlemek için stream

  final StreamController<void> _controller = StreamController<void>.broadcast();

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      _performCalculations();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

Future<void> _performCalculations() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  double totalBTC = 0.0;
  double totalETH = 0.0;
  double totalSOL = 0.0;

  for (int i = 0; i < 25; i++) {
    int userAmount = prefs.getInt('{AmountGraphicCard$i}') ?? 0; // Ekran kartı adeti
    if (userAmount > 0) {
      double power = GraphicCardData.graphicCards['$i']?.power ?? 1.0;
      String assignedValue = prefs.getString('{idGraphicCard$i}') ?? 'BTC';

      double alpha = 1.8 + random.nextDouble() * (1.55 - 1.4);
      print(btcPrice);
      switch (assignedValue) {
        case 'BTC':
          totalBTC += calculateEarnings(power, userAmount, btcPrice!, alpha);
          break;
        case 'ETH':
          totalETH += calculateEarnings(power, userAmount, ethPrice!, alpha);
          break;
        case 'SOL':
          totalSOL += calculateEarnings(power, userAmount, solPrice!, alpha);
          break;
        default:
          break;
      }
    }
  }

  // Güncel coin miktarlarını SharedPreferences'e yazma
  double currentBTC = prefs.getDouble('userBTC') ?? 0.0;
  double currentETH = prefs.getDouble('userETH') ?? 0.0;
  double currentSOL = prefs.getDouble('userSOL') ?? 0.0;
  double currentUSD = prefs.getDouble('userCash') ?? 0.0;

  double updatedBTC = currentBTC + totalBTC;
  double updatedETH = currentETH + totalETH;
  double updatedSOL = currentSOL + totalSOL;

  await prefs.setDouble('userBTC', updatedBTC);
  await prefs.setDouble('userETH', updatedETH);
  await prefs.setDouble('userSOL', updatedSOL);


  user.updateCoin('BTC', updatedBTC);
  user.updateCoin('ETH', updatedETH);
  user.updateCoin('SOL', updatedSOL);

  // Coin üretimi stream'ini güncelleme
  _coinStreamController.add({
    'BTC': totalBTC,
    'ETH': totalETH,
    'SOL': totalSOL,
  });

  // Toplam coin miktarları stream'ini güncelleme
  _totalCoinStreamController.add({
    'BTC': updatedBTC,
    'ETH': updatedETH,
    'SOL': updatedSOL,
    'USD': currentUSD, 
  });

  notifyEvent();
}


  void notifyEvent() {
    _controller.add(null);  // Event bildirimi
  }
  double calculateEarnings(double power, int userAmount, double coinPrice, double alpha) {
  return (power * userAmount) / pow(coinPrice, alpha);
}
  void dispose() {
    _timer?.cancel();
    _coinStreamController.close();
    _totalCoinStreamController.close();
    _controller.close();
  }
}
