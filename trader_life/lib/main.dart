import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trader_life/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();          // Guarantee next methods
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: []);    // Hide Top & Bottom Bar
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])        // Fix phone to landscape / change for ios
      .then((_) {
    runApp(const MaterialApp(
    home: WelcomeScreen()));
  });
}
