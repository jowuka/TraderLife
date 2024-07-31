import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader_life/data/data_graphic_card.dart';

const int totalGraphicCards = 3;

class SharedPreferencesUtil {
  static SharedPreferences? _prefs;

  // Keys for SharedPreferences

  static const String assignedToWhat = 'idGraphicCard';
  static const String _isAppFirstTimeKey = 'isAppFirstTime';
  static const String howManyGraphicCard = "AmountGraphicCard";

  // Initialization
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    bool isAppFirstTime = _prefs?.getBool(_isAppFirstTimeKey) ?? true;

    if (isAppFirstTime) {
      await _prefs?.setBool(_isAppFirstTimeKey, false);
      for(int i = 0; i < totalGraphicCards; i++) {
        setGraphicCardDataFirstTime(i);
      }
    }
  }
  static Future<void> setGraphicCardDataFirstTime(int idGraphicCard) async {
    await _prefs?.setString("$assignedToWhat$idGraphicCard", "X");
    await _prefs?.setInt("{$howManyGraphicCard$idGraphicCard}", 0);
  }
  static Future<void> setAssignedValue(int id, String value) async {
    await
  }

  static Future<void> setGraphicCardAssignedValue(int idGraphicCard, String value) async { 
    String? temp =  _prefs?.getString("$GraphicCardData$idGraphicCard")?.split(";").last;
    await _prefs?.setString("$GraphicCardData$idGraphicCard", "$value;$temp");
  }
  
  static String? getGraphicCardData(int idGraphicCard) {
    if(_prefs?.getString("$GraphicCardData$idGraphicCard") != null) {
      return _prefs?.getString("$GraphicCardData$idGraphicCard");
    } else {
      return "X";
    }
  }


}
