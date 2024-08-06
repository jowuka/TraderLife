import 'dart:async';

class NotificationCenter {
  NotificationCenter._privateConstructor();

  static final NotificationCenter _instance = NotificationCenter._privateConstructor();

  factory NotificationCenter() {
    return _instance;
  }

  final StreamController<String> _controller = StreamController<String>.broadcast();

  Stream<String> get onEvent => _controller.stream;

  void notify(String event) {
    _controller.add(event);
  }
}