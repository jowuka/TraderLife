
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trader_life/models/user_model.dart';
import 'package:trader_life/models/work_model.dart';
import 'package:trader_life/utility/timer_work.dart';
import 'package:trader_life/widgets/buttons/work_button.dart';
import 'package:trader_life/widgets/configured_text.dart';

class WorkList extends StatelessWidget {
  final Work work;

  const WorkList({super.key, required this.work});

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    final timerService = Provider.of<TimerWork>(context);
    final remainingTime = timerService.getRemainingTime(work.id);
    final isTimerActive = timerService.isTimerActive(work.id);
    final totalTime = work.durationInSeconds;
    final displayTime = isTimerActive ? remainingTime : totalTime;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(work.imageURL, height: 45, width: 45),
        ConfiguredText(text: work.name),
        ConfiguredText(text: "Reward: ${work.reward} USD"),
        Expanded(
          child: Column(
            children: [
              LinearProgressIndicator(
                minHeight: 30,
                value: isTimerActive 
                    ? (remainingTime > 0 ? remainingTime / totalTime : 0.0) 
                    : 1.0,
                backgroundColor: Colors.grey,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              ConfiguredText(text: "Duration: ${displayTime}s"),
            ],
          ),
        ),
        WorkButton(
          onPressed: () {
            timerService.stopAllTimers();
            timerService.startTimer(work.id, work.durationInSeconds, work.reward, userModel);
          },
          isWorking: isTimerActive,
        ),
      ],
    );
  }
}