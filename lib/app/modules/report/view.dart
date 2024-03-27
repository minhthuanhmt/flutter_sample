import 'package:flutter/material.dart';
import 'package:flutter_sample/app/core/utils/extensions.dart';
import 'package:flutter_sample/app/modules/home/controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ReportPage extends StatelessWidget {
  ReportPage({super.key});

  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    debugPrint("HomePage build");
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          var createdTasks = homeCtrl.getTotalTaskCards();
          var completedTasks = homeCtrl.getTotalTasksDone();
          var liveTasks = createdTasks - completedTasks;
          var percent =
              ((completedTasks / createdTasks) * 100).toStringAsFixed(2);
          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(4.0.percentWidth),
                child: Text(
                  "My Report",
                  style:
                      TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.percentWidth),
                child: Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 3.0.percentWidth, horizontal: 4.0.percentWidth),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 3.0.percentWidth, horizontal: 5.0.percentWidth),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatus(Colors.green, liveTasks, "Live"),
                    _buildStatus(Colors.orange, completedTasks, "Completed"),
                    _buildStatus(Colors.blue, createdTasks, "Created"),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0.percentWidth,
              ),
              UnconstrainedBox(
                child: SizedBox(
                  width: 70.0.percentWidth,
                  height: 70.0.percentWidth,
                  child: CircularStepProgressIndicator(
                    totalSteps: createdTasks == 0 ? 1 : createdTasks,
                    currentStep: completedTasks,
                    stepSize: 20,
                    selectedColor: Colors.green,
                    unselectedColor: Colors.grey[200],
                    padding: 0.0,
                    width: 150,
                    height: 150,
                    selectedStepSize: 22,
                    roundedCap: (_, __) => true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${(createdTasks == 0) ? 0 : percent}%",
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 2.0.percentWidth,
                        ),
                        Text(
                          "Efficiency",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Row _buildStatus(Color color, int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 3.0.percentWidth,
          height: 3.0.percentWidth,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 0.5.percentWidth),
          ),
        ),
        SizedBox(
          width: 3.0.percentWidth,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              number.toString(),
              style: TextStyle(
                fontSize: 16.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 2.0.percentWidth,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 12.0.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
