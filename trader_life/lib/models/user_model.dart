class UserModel {
  int userLevel;
  int userExperience;
  double userCash;
  UserModel({
    required this.userLevel,
    required this.userExperience,
    required this.userCash,
  });

  // Method to add experience and possibly level up
  void addExperience(int experience) {
    userExperience += experience;
    while (userExperience >= experienceRequiredForNextLevel()) {
      userExperience -= experienceRequiredForNextLevel();
      userLevel++;
    }
  }

  void addCash(double amount) {
    userCash += amount;
  }

  // Method to subtract cash
  void spendCash(double amount) {
    if (amount > userCash) {
      throw Exception("Not enough cash");
    }
    userCash -= amount;
  }

  int experienceRequiredForNextLevel() {
    return userLevel * 1000; 
  }

}
