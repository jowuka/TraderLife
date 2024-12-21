import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader_life/utility/shared_preferences.dart';
import 'package:trader_life/models/user_wallet.dart';

class UserModel with ChangeNotifier {
  int _userLevel = SharedPreferencesUtil.getUserLevel() ?? 1;  // Varsayılan seviye 1
  int _userExperience = SharedPreferencesUtil.getUserExperience() ?? 0;  // Varsayılan deneyim 0
  double _userCash = SharedPreferencesUtil.getUserCash() ?? 0;  // Varsayılan nakit 0
  
  final UserWallet _userWallet = UserWallet();

  // Getter'lar
  int get userLevel => _userLevel;
  int get userExperience => _userExperience;
  double get userCash => _userCash;

  // Coinlerin toplam miktarı
  Map<String, double> get userCoins {
    return _userWallet.currencies.map((key, value) => MapEntry(key, value.amount));
  }

  // Coinleri yüklemek için SharedPreferences'dan verileri çek
  Future<void> loadCoinsFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var coin in _userWallet.currencies.keys) {
      double amount = prefs.getDouble('user$coin') ?? 0.0;
      _userWallet.updateCurrency(coin, amount);
    }
    notifyListeners();
  }

  void updateCoin(String currencyName, double amount) {
    _userWallet.updateCurrency(currencyName, amount);
    _saveCoinsToPreferences();
    notifyListeners();
  }

  void addExperience(int experience) {
    _userExperience += experience;

    if (_userExperience >= experienceRequiredForNextLevel()) {
      _userLevel += 1;
      _userExperience = 0;
      _saveLevelAndExperienceToPreferences();
      notifyListeners();
      print('Level Up!');
    } else {
      SharedPreferencesUtil.setUserExperience(_userExperience);
      notifyListeners();
    }
  }

  void addCash(double amount) {
    _userCash += amount;
    SharedPreferencesUtil.setUserCash(_userCash);
    notifyListeners();
  }

  bool spendCash(double amount) {
    if (amount > _userCash) {
      return false;
    }
    _userCash -= amount;
    SharedPreferencesUtil.setUserCash(_userCash);
    notifyListeners();
    return true;
  }

  int experienceRequiredForNextLevel() {
    notifyListeners();
    return _userLevel * 100; 
  }

  Future<void> _saveCoinsToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var coin in _userWallet.currencies.keys) {
      await prefs.setDouble('user$coin', _userWallet.getCurrencyAmount(coin));
    }
  }

  void _saveLevelAndExperienceToPreferences() {
    SharedPreferencesUtil.setUserLevel(_userLevel);
    SharedPreferencesUtil.setUserExperience(_userExperience);
  }

  Future<void> loadWalletFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var coin in _userWallet.currencies.keys) {
      double amount = prefs.getDouble('user$coin') ?? 0.0;
      _userWallet.updateCurrency(coin, amount);
    }
    notifyListeners();  // UI'yi güncelle
  }
}
