import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader_life/data/data_graphic_card.dart';
import 'package:trader_life/models/user_model.dart';
import 'package:trader_life/utility/notification_center.dart';

int totalGraphicCards = 25;

class SharedPreferencesUtil {
  static SharedPreferences? _prefs;

  // Keys for SharedPreferences

  static const String assignedToWhat = 'idGraphicCard';
  static const String _isAppFirstTimeKey = 'isAppFirstTime';
  static const String howManyGraphicCard = "AmountGraphicCard";
  static const String _userLevelKey = "userLevel";
  static const String _userExperienceKey = "userExperience";
  static const String _userCashKey = "";

  // Initialization
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    bool isAppFirstTime = _prefs?.getBool(_isAppFirstTimeKey) ?? true;
    if (isAppFirstTime) {
      await _prefs?.setBool(_isAppFirstTimeKey, false);
      for (int i = 0; i < totalGraphicCards; i++) {
        saveUser();
        setGraphicCardDataFirstTime(i);
      }
    }
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
    await _prefs!
        .setInt("{$howManyGraphicCard$i}", support! + 1); // Initial count
    NotificationCenter().notify('graphicCardAdded');
  }

  static Future<void> saveUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('userLevel', 1);
    prefs.setInt('userExperience', 0);
    prefs.setDouble('userCash', 0);
  }

  static Future<UserModel> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userLevel = prefs.getInt(_userLevelKey) ?? 1;
    int userExperience = prefs.getInt(_userExperienceKey) ?? 0;
    double userCash = prefs.getDouble(_userCashKey) ?? 0.0;

    return UserModel(
      userLevel: userLevel,
      userExperience: userExperience,
      userCash: userCash,
    );
  }
}
