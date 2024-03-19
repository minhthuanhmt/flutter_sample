import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sample/app/core/utils/extensions.dart';
import 'package:flutter_sample/app/data/models/task.dart';
import 'package:flutter_sample/app/modules/home/controller.dart';
import 'package:flutter_sample/app/widget/icons.dart';
import 'package:get/get.dart';

class AddCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.percentWidth;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.percentWidth),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.percentWidth),
            title: "Task Type",
            radius: 5,
            content: Form(
              key: homeCtrl.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.percentWidth),
                    child: TextFormField(
                      controller: homeCtrl.editController,
                      decoration: InputDecoration(
                        labelText: "Task Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter a task name";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0.percentWidth),
                    child: Wrap(
                      spacing: 2.0.percentWidth,
                      children: icons
                          .map(
                            (e) => Obx(() {
                              return ChoiceChip(
                                selectedColor: Colors.grey[200],
                                pressElevation: 0,
                                backgroundColor: Colors.white,
                                label: e,
                                selected: homeCtrl.chipIndex.value ==
                                    icons.indexOf(e),
                                onSelected: (bool selected) {
                                  homeCtrl.chipIndex.value =
                                      selected ? icons.indexOf(e) : 0;
                                },
                              );
                            }),
                          )
                          .toList(),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        minimumSize: const Size(150, 40),
                      ),
                      onPressed: () {
                        if (homeCtrl.formKey.currentState!.validate()) {
                          int icon =
                              icons[homeCtrl.chipIndex.value].icon!.codePoint;
                          String color =
                              icons[homeCtrl.chipIndex.value].color!.toHex();
                          var task = Task(
                            title: homeCtrl.editController.text,
                            icon: icon,
                            color: color,
                          );
                          Get.back();
                          homeCtrl.addTask(task)
                              ? EasyLoading.showSuccess("Create success")
                              : EasyLoading.showError("Duplicated task");
                        }
                      },
                      child: const Text("Confirm")),
                ],
              ),
            ),
          );
          homeCtrl.editController.clear();
          homeCtrl.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 20.0.sp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
