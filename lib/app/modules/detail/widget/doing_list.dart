import 'package:flutter/material.dart';
import 'package:flutter_sample/app/core/utils/extensions.dart';
import 'package:flutter_sample/app/modules/home/controller.dart';
import 'package:get/get.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
          ? Column(
              children: [
                Image.asset(
                  "assets/images/task.jpg",
                  fit: BoxFit.cover,
                  width: 65.0.percentWidth,
                ),
                Text("Add task",
                    style: TextStyle(
                        fontSize: 12.0.sp, fontWeight: FontWeight.bold)),
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...homeCtrl.doingTodos
                    .map(
                      (element) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.0.percentWidth,
                            vertical: 3.0.percentWidth),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: element["done"],
                                fillColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.transparent),
                                onChanged: (value) {
                                  homeCtrl.doneTodo(element["title"]);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.0.percentWidth),
                              child: Text(element["title"],
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                Visibility(
                  visible: homeCtrl.doingTodos.isNotEmpty &&
                      homeCtrl.doneTodos.isNotEmpty,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.percentWidth),
                    child: const Divider(thickness: 2),
                  ),
                ),
              ],
            ),
    );
  }
}
