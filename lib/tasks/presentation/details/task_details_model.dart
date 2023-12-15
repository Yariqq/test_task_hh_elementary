import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:test_task_hh_elementary/tasks/domain/entity/task.dart';

class TaskDetailsModel extends ElementaryModel {
  final ValueNotifier<TaskDetailsListenableModel> data =
      ValueNotifier(const TaskDetailsListenableModel());
}

class TaskDetailsListenableModel {
  final Task task;
  final bool shouldEdit;

  const TaskDetailsListenableModel({
    this.task = const Task.empty(),
    this.shouldEdit = true,
  });

  TaskDetailsListenableModel copyWith({
    Task? task,
    bool? shouldEdit,
  }) {
    return TaskDetailsListenableModel(
      task: task ?? this.task,
      shouldEdit: shouldEdit ?? this.shouldEdit,
    );
  }
}
