import 'package:flutter/material.dart';
import 'package:trader_life/main_game.dart';
import 'package:trader_life/utility/shared_preferences.dart';
import 'package:trader_life/models/user_model.dart';
import 'package:trader_life/utility/timer.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeData();
    TimerService().startTimer();
  }

  Future<void> _initializeData() async {
    // Initialize SharedPreferences and other data
    await SharedPreferencesUtil.init();

    // Simulate some data loading progress
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          _progressValue = i * 0.1;
        });
      });
    }

    // Retrieve user data
    UserModel user = await SharedPreferencesUtil.getUserData();

    // After initialization, navigate to MainGame
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Game(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Loading...'),
            const SizedBox(height: 20),
            CircularProgressIndicator(value: _progressValue, color: Colors.blueGrey.shade700,),
            const SizedBox(height: 20),
            Text('${(_progressValue * 100).toInt()}%'),
          ],
        ),
      ),
    );
  }
}
