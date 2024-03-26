import 'package:flutter/material.dart';
import 'package:flutter_sample/app/core/utils/extensions.dart';
import 'package:flutter_sample/app/modules/home/controller.dart';
import 'package:get/get.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DoneList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doneTodos.isEmpty
          ? Container()
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 9.0.percentWidth, vertical: 3.0.percentWidth),
                  child: Text(
                    "Completed (${homeCtrl.doneTodos.length})",
                    style: TextStyle(
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...homeCtrl.doneTodos.map((element) => Dismissible(
                      key: ObjectKey(element),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        homeCtrl.deleteDoneTodo(element);
                      },
                      background: Container(
                        color: Colors.red.withOpacity(0.8),
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.0.percentWidth),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.0.percentWidth,
                            vertical: 3.0.percentWidth),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check,
                              color: Colors.blue,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.0.percentWidth),
                              child: Text("${element["title"]}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
    );
  }
}
