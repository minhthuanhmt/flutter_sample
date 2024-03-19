import 'package:flutter/material.dart';
import 'package:flutter_sample/app/core/utils/extensions.dart';
import 'package:flutter_sample/app/modules/home/controller.dart';
import 'package:flutter_sample/app/modules/home/widget/add_card.dart';
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
                      .map((element) => TaskCard(task: element))
                      .toList(),
                  AddCard()
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
