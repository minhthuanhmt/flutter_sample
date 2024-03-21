import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/app/data/services/storage/repository.dart';
import 'package:get/get.dart';

import '../../data/models/task.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;

  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final tasks = <Task>[].obs;
  final task = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }

  void changeChipIndex(int index) {
    chipIndex.value = index;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    } else {
      tasks.add(task);
      return true;
    }
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  bool updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containeTodo(todos, title)) {
      return false;
    }
    var todo = {"title": title, "done": false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    tasks[tasks.indexWhere((element) => element == task)] = newTask;
    tasks.refresh();
    return true;
  }

  bool containeTodo(List todos, String title) {
    return todos.any((element) => element["title"] == title);
  }

  void changeTodoStatus(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i < select.length; i++) {
      if (select[i]["done"]) {
        doneTodos.add(select[i]);
      } else {
        doingTodos.add(select[i]);
      }
    }
  }

  bool addTodo(String text) {
    var todo = {"title": text, "done": false};
    if (doingTodos
        .any((element) => mapEquals<String, dynamic>(todo, element))) {
      return false;
    }
    var doneTodo = {"title": text, "done": true};
    if (doneTodos
        .any((element) => mapEquals<String, dynamic>(doneTodo, element))) {
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  void updateTodos() {
    var todos = <dynamic>[];
    todos.addAll(doingTodos);
    todos.addAll(doneTodos);
    var newTask = task.value!.copyWith(todos: todos);
    tasks[tasks.indexWhere((element) => element == task.value)] = newTask;
    tasks.refresh();
  }

  void doneTodo(String title) {
    var index = doingTodos.indexWhere((element) => element["title"] == title);
    var todo = doingTodos.removeAt(index);
    todo["done"] = true;
    doneTodos.add(todo);
    updateTodos();
  }
}
