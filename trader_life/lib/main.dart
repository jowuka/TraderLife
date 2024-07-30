import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader_life/main_game.dart';
import 'package:trader_life/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Guarantee next methods

  // Hide Top & Bottom Bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: []);

  // Fix phone to landscape / change for ios
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(isAppFirstTime: prefs.getBool('isAppFirstTime') ?? true));
}

class MyApp extends StatelessWidget {
  final bool isAppFirstTime;

  const MyApp({required this.isAppFirstTime, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isAppFirstTime
          ? const WelcomeScreen()
          : const Game(), // Navigate to the appropriate screen
    );
  }
}
