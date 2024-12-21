import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader_life/data/data_currency.dart';

class PriceUpdateService {
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
    Map<String, double> newPrices = {
      'BTC': currentPriceData['price'],
      // Diğer coinler için de benzer şekilde fiyatları ekleyin
      // 'ETH': ...,
      // 'SOL': ...,
    };

    CoinData.updatePrices(newPrices);

    // Save current day to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_currentDayKey, _currentDay);

    // Notify listeners
    notifyListeners();

    _currentDay++;
  }

  void dispose() {
    _timer?.cancel();
  }

  void notifyListeners() {
    // Implement notification logic here
  }
}