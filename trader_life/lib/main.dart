import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trader_life/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(const MaterialApp(
    home: WelcomeScreen()));
  });
}
