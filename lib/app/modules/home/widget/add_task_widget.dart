import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sample/app/core/utils/extensions.dart';
import 'package:flutter_sample/app/modules/home/controller.dart';
import 'package:get/get.dart';

class AddTaskWidget extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  AddTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.percentWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                        homeCtrl.editController.clear();
                        homeCtrl.changeTask(null);
                      },
                      icon: const Icon(Icons.close)),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      if (homeCtrl.formKey.currentState!.validate()) {
                        if (homeCtrl.taskCard.value == null) {
                          EasyLoading.showError("Please select a task");
                        } else {
                          var success = homeCtrl.updateTask(
                            homeCtrl.taskCard.value!,
                            homeCtrl.editController.text,
                          );
                          if (success) {
                            EasyLoading.showSuccess("Item add successfully");
                            Get.back();
                            homeCtrl.editController.clear();
                            homeCtrl.changeTask(null);
                          } else {
                            EasyLoading.showError("Task already exists");
                          }
                        }
                      }
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 14.0.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.percentWidth),
              child: Text("New task",
                  style: TextStyle(
                      fontSize: 20.0.sp, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.percentWidth),
              child: TextFormField(
                controller: homeCtrl.editController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                    ),
                  ),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter title";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 5.0.percentWidth,
                left: 5.0.percentWidth,
                right: 5.0.percentWidth,
                bottom: 2.0.percentWidth,
              ),
              child: Text(
                "Add to list",
                style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal),
              ),
            ),
            ...homeCtrl.taskCards
                .map(
                  (element) => Obx(
                    () => InkWell(
                      onTap: () {
                        if (homeCtrl.taskCard.value == element) {
                          homeCtrl.changeTask(null);
                        } else {
                          homeCtrl.changeTask(element);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0.percentWidth,
                            horizontal: 5.0.percentWidth),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                IconData(element.icon,
                                    fontFamily: 'MaterialIcons'),
                                color: HexColor.fromHex(element.color),
                              ),
                              SizedBox(width: 3.0.percentWidth),
                              Text(
                                element.title,
                                style: TextStyle(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                            Visibility(
                              visible: homeCtrl.taskCard.value == element,
                              child: const Icon(
                                Icons.check,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}
