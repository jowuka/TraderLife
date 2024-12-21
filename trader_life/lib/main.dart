import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader_life/main_game.dart';
import 'package:trader_life/utility/price_update_service.dart';
import 'package:trader_life/utility/shared_preferences.dart';
import 'package:trader_life/utility/timer_work.dart';
import 'package:trader_life/welcome_screen.dart';
import 'package:trader_life/utility/timer_mining.dart';
import 'package:trader_life/models/user_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hide Top & Bottom Bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: []);

  // Fix phone to landscape / change for iOS
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  SharedPreferencesUtil.init();
  TimerService().startTimer();
  final priceUpdateService = PriceUpdateService();
  await priceUpdateService.initialize();

  bool isAppFirstTime = prefs.getBool('isAppFirstTime') ?? true;

runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => TimerWork()),
      ],
      child: MyApp(isAppFirstTime: isAppFirstTime),
    ),
    
  );
}

class MyApp extends StatelessWidget {
  final bool isAppFirstTime;

  const MyApp({required this.isAppFirstTime, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isAppFirstTime
          ? const WelcomeScreen()
          : const Game(), // İlk kez mi açıldığını kontrol ederek yönlendir
    );
  }
}
