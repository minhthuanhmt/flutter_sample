import 'package:flutter/material.dart';
import 'package:flutter_sample/app/core/utils/extensions.dart';
import 'package:flutter_sample/app/data/models/task.dart';
import 'package:flutter_sample/app/modules/detail/view.dart';
import 'package:flutter_sample/app/modules/home/controller.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  TaskCard({super.key, required this.task});

  final homeCtrl = Get.find<HomeController>();
  final Task task;

  @override
  Widget build(BuildContext context) {
    var squareWidth = Get.width - 12.0.percentWidth;
    final color = HexColor.fromHex(task.color);
    return GestureDetector(
      onTap: () {
        homeCtrl.changeTask(task);
        homeCtrl.changeTodoStatus(task.todos ?? []);
        Get.to(DetailPage());
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.percentWidth),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps: homeCtrl.isTodosEmpty(task) ? 1 : task.todos!.length,
              currentStep:
                  homeCtrl.isTodosEmpty(task) ? 0 : homeCtrl.getDoneTodos(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(0.5), color],
              ),
              unselectedGradientColor: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.white],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.percentWidth),
              child: Icon(IconData(task.icon, fontFamily: 'MaterialIcons'),
                  color: color),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.percentWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                        fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2.0.percentWidth,
                  ),
                  Text(
                    "${task.todos?.length ?? 0} tasks",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
