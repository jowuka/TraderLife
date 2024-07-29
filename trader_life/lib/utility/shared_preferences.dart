import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader_life/models/model_graphic_card.dart';

class SharedPreferencesUtil {
  static SharedPreferences? _prefs;

  // Keys for SharedPreferences
  static const String _assignedValueKey = 'assignedValue';
  static const String _exampleKey = 'exampleKey';
  static const String _isAppFirstTimeKey = 'isAppFirstTime';

  static const String assignedValueOfGraphicCard = "AssignedValueOfGraphicCard";

  // Initialization
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    bool isAppFirstTime = _prefs?.getBool(_isAppFirstTimeKey) ?? true;

    if (isAppFirstTime) {
      // Perform first-time initialization
      await _prefs?.setBool(_isAppFirstTimeKey, false);
      _prefs?.setString(assignedValueOfGraphicCard, "NULL");
    }
  }

  // Setter and Getter for AssignedValue
  static Future<void> setAssignedValue(String value) async {
    await _prefs?.setString(_assignedValueKey, value);
  }

  static String? getAssignedValue() {
    return _prefs?.getString(_assignedValueKey);
  }

  // Example: Setter and Getter for another variable
  static Future<void> setExampleValue(String value) async {
    await _prefs?.setString(_exampleKey, value);
  }

  static String? getExampleValue() {
    return _prefs?.getString(_exampleKey);
  }

  static String? getAssignedValueOfGraphicCard() {
    if (assignedValueOfGraphicCard != null) {
      return _prefs?.getString(assignedValueOfGraphicCard);
    } else {
      return "X";
    }
  }
  // Add more setter and getter methods for other variables as needed
}
