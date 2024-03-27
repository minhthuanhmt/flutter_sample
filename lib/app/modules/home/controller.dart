import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/app/data/services/storage/repository.dart';
import 'package:get/get.dart';

import '../../data/models/task_card.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;

  HomeController({required this.taskRepository});

  final tabIndex = 0.obs;

  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final taskCards = <TaskCard>[].obs;
  final taskCard = Rx<TaskCard?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    taskCards.assignAll(taskRepository.readTaskCards());
    ever(taskCards, (_) => taskRepository.writeTaskCards(taskCards));
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

  void changeTask(TaskCard? select) {
    taskCard.value = select;
  }

  bool addTaskCard(TaskCard taskCard) {
    if (taskCards.contains(taskCard)) {
      return false;
    } else {
      taskCards.add(taskCard);
      return true;
    }
  }

  void deleteTaskCard(TaskCard taskCard) {
    taskCards.remove(taskCard);
  }

  bool updateTask(TaskCard taskCard, String title) {
    var todos = taskCard.todos ?? [];
    if (containeTodo(todos, title)) {
      return false;
    }
    var todo = {"title": title, "done": false};
    todos.add(todo);
    var newTask = taskCard.copyWith(todos: todos);
    taskCards[taskCards.indexWhere((element) => element == taskCard)] = newTask;
    taskCards.refresh();
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
    var newTask = taskCard.value!.copyWith(todos: todos);
    taskCards[taskCards.indexWhere((element) => element == taskCard.value)] =
        newTask;
    taskCards.refresh();
  }

  void doneTodo(String title) {
    var index = doingTodos.indexWhere((element) => element["title"] == title);
    var todo = doingTodos.removeAt(index);
    todo["done"] = true;
    doneTodos.add(todo);
    updateTodos();
  }

  void deleteDoneTodo(dynamic doneTodo) {
    var todo = doneTodos.indexWhere((element) => element == doneTodo);
    doneTodos.removeAt(todo);
    doneTodos.refresh();
  }

  bool isTodosEmpty(TaskCard task) {
    return task.todos == null || task.todos!.isEmpty;
  }

  int getDoneTodos(TaskCard task) {
    return task.todos!.where((element) => element["done"]).length;
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  int getTotalTaskCards() {
    var res = 0;
    for (int i = 0; i < taskCards.length; i++) {
      if (taskCards[i].todos != null) {
        res += taskCards[i].todos!.length;
      }
    }
    return res;
  }

  int getTotalTasksDone() {
    var res = 0;
    for (int i = 0; i < taskCards.length; i++) {
      if (taskCards[i].todos != null) {
        for (int j = 0; j < taskCards[i].todos!.length; j++) {
          if (taskCards[i].todos![j]["done"] == true) {
            res++;
          }
        }
      }
    }
    return res;
  }
}
