import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trader_life/loading_screen.dart';
import 'package:trader_life/utility/shared_preferences.dart';
import 'package:trader_life/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Guarantee next methods

  // Hide Top & Bottom Bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: []);

  // Fix phone to landscape / change for ios
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      
  bool isAppFirstTime = await SharedPreferencesUtil.isAppFirstTime();
  await SharedPreferencesUtil.init();
  

  runApp(MyApp(isAppFirstTime: isAppFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isAppFirstTime;

  const MyApp({required this.isAppFirstTime, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isAppFirstTime
          ? const WelcomeScreen()
          : const LoadingScreen(), // Navigate to the appropriate screen
    );
  }
}
