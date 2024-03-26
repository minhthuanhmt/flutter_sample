import 'dart:convert';

import 'package:flutter_sample/app/core/utils/keys.dart';
import 'package:flutter_sample/app/data/services/storage/services.dart';
import 'package:get/get.dart';

import '../../models/task_card.dart';

class TaskCardProvider {
  StorageService _storageService = Get.find<StorageService>();

  List<TaskCard> readTaskCards() {
    var tasks = <TaskCard>[];
    jsonDecode(_storageService.read(taskKey).toString()).forEach((taskCard) {
      tasks.add(TaskCard.fromJson(taskCard));
    });
    return tasks;
  }

  void writeTaskCards(List<TaskCard> taskCards) {
    _storageService.write(taskKey, jsonEncode(taskCards));
  }
}
