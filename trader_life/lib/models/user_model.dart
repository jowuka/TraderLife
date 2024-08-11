import 'package:trader_life/utility/shared_preferences.dart';

class UserModel {
  static int userLevel = SharedPreferencesUtil.getUserLevel();
  static int userExperience = SharedPreferencesUtil.getUserExperience();
  static int userCash = SharedPreferencesUtil.getUserCash();


  void addExperience(int experience) {
    userExperience += experience;
    if (userExperience >= experienceRequiredForNextLevel()) {
      SharedPreferencesUtil.setUserLevel((SharedPreferencesUtil.getUserLevel() + 1));
      userExperience = 0;
      SharedPreferencesUtil.setUserExperience(0);
      print('level up');
    }
  }

  void addCash(int amount) {
    userCash += amount;
    SharedPreferencesUtil.setUserCash(SharedPreferencesUtil.getUserCash() + amount);
  }

  // Method to subtract cash
  static bool spendCash(int amount) {
    if (amount > userCash) {
      return false;
    }
    userCash -= amount;
    SharedPreferencesUtil.setUserCash((SharedPreferencesUtil.getUserCash() - amount));
    return true;
    }

  int experienceRequiredForNextLevel() {
    return userLevel * 100; 
  }

}
