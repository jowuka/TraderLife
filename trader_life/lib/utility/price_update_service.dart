import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader_life/data/data_currency.dart';
import 'package:trader_life/models/currency_model.dart';

class PriceUpdateService {
  static const String _priceDataKey = 'price_data';
  static const String _currentDayKey = 'current_day';
  
  Timer? _timer;
  List<Map<String, dynamic>> _priceData = [];
  int _currentDay = 0;

  Future<void> initialize() async {
    await _loadPriceData();
    await _loadCurrentDay();
    _startTimer();
  }

  Future<void> _loadPriceData() async {
    final String jsonString = await rootBundle.loadString('assets/bitcoin_historical_data.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    _priceData = List<Map<String, dynamic>>.from(jsonData['BTC']['historicalData']);
  }

  Future<void> _loadCurrentDay() async {
    final prefs = await SharedPreferences.getInstance();
    _currentDay = prefs.getInt(_currentDayKey) ?? 0;
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (_) => _updatePrices());
  }

  Future<void> _updatePrices() async {
    if (_currentDay >= _priceData.length) {
      _currentDay = 0; // Reset to the beginning if we've reached the end
    }

    final currentPriceData = _priceData[_currentDay];
    
    // Update coin prices
    CoinData.coins['BTC']!.currentPrice = currentPriceData['price'];
    // Update other coin prices similarly...

    // Save current day to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_currentDayKey, _currentDay);

    // Notify listeners (you'll implement this next)
    notifyListeners();

    _currentDay++;
  }

  void dispose() {
    _timer?.cancel();
  }

  // This method will be used to notify listeners of price changes
  void notifyListeners() {
    // Implement notification logic here
  }
}