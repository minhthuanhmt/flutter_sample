import 'package:flutter_sample/app/data/providers/task/provider.dart';

import '../../models/task_card.dart';

class TaskRepository {
  TaskCardProvider taskCardProvider;
  TaskRepository({required this.taskCardProvider});

  List<TaskCard> readTaskCards() {
    return taskCardProvider.readTaskCards();
  }

  void writeTaskCards(List<TaskCard> taskCards) {
    taskCardProvider.writeTaskCards(taskCards);
  }
}
