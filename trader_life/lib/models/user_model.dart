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

  // Method to add cash
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

  // Method to calculate experience required for the next level
  int experienceRequiredForNextLevel() {
    return userLevel * 1000; // Example: next level requires 100 * current level experience points
  }

}
