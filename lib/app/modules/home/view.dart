import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sample/app/core/utils/extensions.dart';
import 'package:flutter_sample/app/data/models/task_card.dart';
import 'package:flutter_sample/app/modules/home/controller.dart';
import 'package:flutter_sample/app/modules/home/widget/add_task_card_widget.dart';
import 'package:flutter_sample/app/modules/home/widget/add_task_widget.dart';
import 'package:flutter_sample/app/modules/home/widget/task_card_widget.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: Text(
                "My List",
                style: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(() {
              return GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  ...controller.taskCards
                      .map(
                        (element) => LongPressDraggable(
                          data: element,
                          child: TaskCardWidget(taskCard: element),
                          feedback: Opacity(
                            opacity: 0.8,
                            child: TaskCardWidget(
                              taskCard: element,
                            ),
                          ),
                          onDragStarted: () {
                            controller.changeDeleting(true);
                          },
                          onDraggableCanceled: (velocity, offset) {
                            controller.changeDeleting(false);
                          },
                          onDragEnd: (details) {
                            controller.changeDeleting(false);
                          },
                        ),
                      )
                      .toList(),
                  AddTaskCardWidget()
                ],
              );
            }),
          ],
        ),
      ),
      floatingActionButton: DragTarget<TaskCard>(
        builder: (BuildContext context, List<Object?> candidateData,
            List<dynamic> rejectedData) {
          return Obx(() {
            return FloatingActionButton(
              backgroundColor:
                  controller.deleting.value ? Colors.red : Colors.blue,
              onPressed: () {
                if (controller.taskCards.isNotEmpty) {
                  Get.to(() => AddTaskWidget(),
                      transition: Transition.downToUp);
                } else {
                  EasyLoading.showError("Please add task first");
                }
              },
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            );
          });
        },
        onAcceptWithDetails: (task) {
          controller.deleteTaskCard(task.data);
          EasyLoading.showSuccess("Delete Success");
        },
      ),
    );
  }
}
