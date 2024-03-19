import 'package:flutter_sample/app/data/providers/task/provider.dart';
import 'package:flutter_sample/app/data/services/storage/repository.dart';
import 'package:flutter_sample/app/modules/home/controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(
          taskRepository: TaskRepository(
            taskProvider: TaskProvider(),
          ),
        ));
  }
}
