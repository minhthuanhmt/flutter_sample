import 'dart:convert';

import 'package:flutter_sample/app/core/utils/keys.dart';
import 'package:flutter_sample/app/data/services/storage/services.dart';
import 'package:get/get.dart';

import '../../models/task.dart';

class TaskProvider {
  StorageService _storageService = Get.find<StorageService>();

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storageService.read(taskKey).toString()).forEach((task) {
      tasks.add(Task.fromJson(task));
    });
    return tasks;
  }
  void writeTasks(List<Task> tasks) {
    _storageService.write(taskKey, jsonEncode(tasks));
  }
}
