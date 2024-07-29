// ignore_for_file: constant_identifier_names


enum AssignedValue {
  X,
  BTC,
  ETH,
  SOL,
}

class GraphicCard {
  int id;
  String model;
  String imageURL;
  double power;
  String assignedValue;
  double price;
  GraphicCard(
      {required this.id,
      required this.model,
      required this.power,
      required this.imageURL,
      required this.assignedValue,
      required this.price});
}