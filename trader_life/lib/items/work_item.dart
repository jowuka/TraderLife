import 'package:device_screen_size/device_screen_size.dart';
import 'package:flutter/material.dart';
import 'package:trader_life/data/work_data.dart';
import 'package:trader_life/lists/work_list.dart';
import 'package:trader_life/models/work_model.dart';

class WorkItem extends StatelessWidget {
  const WorkItem({super.key});

  @override
  Widget build(BuildContext context) {
    double listViewHeight = DeviceScreenSize.screenHeightInPercentage(context, percentage: 0.64);

    List<Work> sortedWorks = WorkData.works.values.toList()..sort((a, b) => a.id.compareTo(b.id));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: SizedBox(
        height: listViewHeight,
        child: ListView.separated(
          itemCount: sortedWorks.length,
          itemBuilder: (context, index) {
            final work = sortedWorks[index];
            return WorkList(work: work);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        ),
      ),
    );
  }
}