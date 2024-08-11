import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader_life/data/data_graphic_card.dart';
import 'package:trader_life/utility/notification_center.dart';

int totalGraphicCards = 25;

class SharedPreferencesUtil {
  static SharedPreferences? _prefs;

  // Keys for SharedPreferences

  static const String assignedToWhat = 'idGraphicCard';
  static const String _isAppFirstTimeKey = 'isAppFirstTime';
  static const String howManyGraphicCard = "AmountGraphicCard";
  static const String userCash = 'userCash';
  static const String userLevel = 'userLevel';
  static const String userExperience = 'userExperience';
  // Initialization
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    bool isAppFirstTime = _prefs?.getBool(_isAppFirstTimeKey) ?? true;
    if (isAppFirstTime) {
      await _prefs?.setBool(_isAppFirstTimeKey, false);
      for (int i = 0; i < totalGraphicCards; i++) {
        setGraphicCardDataFirstTime(i);
        setUserFirstTime();
      }
    }
  }
   static Future<void> setUserFirstTime() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs?.setInt(userCash, 0);
    await _prefs?.setInt(userLevel, 1);
    await _prefs?.setInt(userExperience, 0);
  }
   static getUserCash() {
    return _prefs!.getInt(userCash);
  }
   static getUserLevel() {
    return _prefs!.getInt(userLevel);
  }
   static getUserExperience() {
    return _prefs!.getInt(userExperience);
  }
    static Future<void> setUserCash(int value) async {
    await _prefs?.setInt(userCash, value);
  }
    static Future<void> setUserLevel(int value) async {
    await _prefs?.setInt(userLevel, value);
  }
    static Future<void> setUserExperience(int value) async {
    await _prefs?.setInt(userExperience, value);
  }

  static Future<bool> userHasGraphicCard(int id) async {
    final userGraphicCards = _prefs!.getInt("{$howManyGraphicCard$id}");
    return userGraphicCards! > 0;
  }
  static Future<void> setGraphicCardDataFirstTime(int idGraphicCard) async {
    await _prefs?.setString("{$assignedToWhat$idGraphicCard}", "X");
    await _prefs?.setInt("{$howManyGraphicCard$idGraphicCard}", 0);
  }

  static Future<void> setAssignedValue(int id, String value) async {
    await _prefs?.setString("{$assignedToWhat$id}", value);
  }

  static Future<void> setGraphicCardAssignedValue(
      int idGraphicCard, String value) async {
    String? temp =
        _prefs?.getString("{$GraphicCardData$idGraphicCard}")?.split(";").last;
    await _prefs?.setString("{$GraphicCardData$idGraphicCard}", "$value;$temp");
  }

  static getAmountGraphicCard(int i) {
    return _prefs!.getInt("{$howManyGraphicCard$i}");
  }

  static getAssignedValue(int i) {
    return _prefs!.getString("{$assignedToWhat$i}");
  }

  static addUserGraphicCard(int i) async {
    int? support = _prefs!.getInt("{$howManyGraphicCard$i}");
    await _prefs!.setInt(
      "{$howManyGraphicCard$i}", support! + 1); // Initial count
    NotificationCenter().notify('graphicCardAdded');
  }
}