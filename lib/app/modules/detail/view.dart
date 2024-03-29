import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sample/app/core/utils/extensions.dart';
import 'package:flutter_sample/app/modules/detail/widget/doing_list_widget.dart';
import 'package:flutter_sample/app/modules/detail/widget/done_list_widget.dart';
import 'package:flutter_sample/app/modules/home/controller.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DetailPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.taskCard.value!;
    var color = HexColor.fromHex(task.color);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Form(
          key: homeCtrl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.percentWidth),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        homeCtrl.updateTodos();
                        homeCtrl.changeTask(null);
                        homeCtrl.editController.clear();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.percentWidth),
                child: Row(
                  children: [
                    Icon(
                      IconData(task.icon, fontFamily: 'MaterialIcons'),
                      color: color,
                    ),
                    SizedBox(
                      width: 3.0.percentWidth,
                    ),
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                var totalTodos =
                    homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;
                return Padding(
                  padding: EdgeInsets.only(
                      left: 16.0.percentWidth,
                      top: 3.0.percentWidth,
                      right: 16.0.percentWidth),
                  child: Row(
                    children: [
                      Text(
                        "$totalTodos Tasks",
                        style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 3.0.percentWidth,
                      ),
                      Expanded(
                        child: StepProgressIndicator(
                          totalSteps: totalTodos == 0 ? 1 : totalTodos,
                          currentStep: homeCtrl.doneTodos.length,
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
                            colors: [Colors.grey, Colors.grey],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5.0.percentWidth, vertical: 2.0.percentWidth),
                child: TextFormField(
                  controller: homeCtrl.editController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                    prefixIcon: Icon(Icons.check_box_outline_blank,
                        color: Colors.grey[400]),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (homeCtrl.formKey.currentState!.validate()) {
                          var success = homeCtrl.addTodo(
                            homeCtrl.editController.text,
                          );
                          if (success) {
                            EasyLoading.showSuccess("Todo item add success");
                          } else {
                            EasyLoading.showError("Todo item already exists");
                          }
                          homeCtrl.editController.clear();
                        }
                      },
                      icon: const Icon(Icons.done),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter a task name";
                    }
                    return null;
                  },
                ),
              ),
              DoingListWidget(),
              DoneListWidget()
            ],
          ),
        ),
      ),
    );
  }
}
