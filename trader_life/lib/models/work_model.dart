

class Work {
  String id;
  String name;
  String imageURL;
  double reward;
  int durationInSeconds;
  int remainingTime; // New field to track remaining time

  Work({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.reward,
    required this.durationInSeconds,
    this.remainingTime = 0, // Initialize to 0, can be set when work starts
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageURL': imageURL,
      'reward': reward,
      'durationInSeconds': durationInSeconds,
      'remainingTime': remainingTime,
    };
  }

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      id: json['id'],
      name: json['name'],
      imageURL: json['imageURL'],
      reward: json['reward'],
      durationInSeconds: json['durationInSeconds'],
      remainingTime: json['remainingTime'],
    );
  }
}