import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader_life/data/data_graphic_card.dart';

const int totalGraphicCards = 3;

class SharedPreferencesUtil {
  static SharedPreferences? _prefs;

  // Keys for SharedPreferences
  static const String _assignedValueKey = 'assignedValue';
  static const String graphicCardData = 'idGraphicCard';
  static const String _isAppFirstTimeKey = 'isAppFirstTime';

  static const String assignedValueOfGraphicCard = "AssignedValueOfGraphicCard";

  // Initialization
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    bool isAppFirstTime = _prefs?.getBool(_isAppFirstTimeKey) ?? true;

    if (isAppFirstTime) {
      await _prefs?.setBool(_isAppFirstTimeKey, false);
      for(int i = 0; i < totalGraphicCards; i++) {
        setGraphicCardDataFirstTime(i);
      }
      _prefs?.setString(assignedValueOfGraphicCard, "X");
    }
  }
  static Future<void> setGraphicCardDataFirstTime(int idGraphicCard) async {
    await _prefs?.setString("$GraphicCardData$idGraphicCard", "X;0");
  }

  static Future<void> setGraphicCardAssignedValue(int idGraphicCard, String value) async { 
    String? temp =  _prefs?.getString("$GraphicCardData$idGraphicCard")?.split(";").last;
    await _prefs?.setString("$GraphicCardData$idGraphicCard", "$value;$temp");
  }
  
  static String? getGraphicCardData(int idGraphicCard) {
    return _prefs?.getString("$GraphicCardData$idGraphicCard");
  }
  // Setter and Getter for AssignedValue
  static Future<void> setAssignedValue(String value) async {
    await _prefs?.setString(_assignedValueKey, value);
  }

  static String? getAssignedValue() {
    return _prefs?.getString(_assignedValueKey);
  }

  // Example: Setter and Getter for another variable

  static String? getAssignedValueOfGraphicCard() {
      return _prefs?.getString(assignedValueOfGraphicCard);
  }
  // Add more setter and getter methods for other variables as needed
}
