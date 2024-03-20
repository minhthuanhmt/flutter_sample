import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sample/app/core/utils/extensions.dart';
import 'package:flutter_sample/app/data/models/task.dart';
import 'package:flutter_sample/app/modules/home/controller.dart';
import 'package:flutter_sample/app/modules/home/widget/add_card.dart';
import 'package:flutter_sample/app/modules/home/widget/add_dialog.dart';
import 'package:flutter_sample/app/modules/home/widget/task_card.dart';
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
                  ...controller.tasks
                      .map(
                        (element) => LongPressDraggable(
                          data: element,
                          child: TaskCard(task: element),
                          feedback: Opacity(
                            opacity: 0.8,
                            child: TaskCard(
                              task: element,
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
                  AddCard()
                ],
              );
            }),
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (BuildContext context, List<Object?> candidateData,
            List<dynamic> rejectedData) {
          return Obx(() {
            return FloatingActionButton(
              backgroundColor:
                  controller.deleting.value ? Colors.red : Colors.blue,
              onPressed: () {
                Get.to(() => AddDialog(), transition: Transition.downToUp);
              },
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            );
          });
        },
        onAcceptWithDetails: (task) {
          controller.deleteTask(task.data);
          EasyLoading.showSuccess("Delete Success");
        },
      ),
    );
  }
}
