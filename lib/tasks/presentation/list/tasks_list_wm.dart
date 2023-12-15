import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_task_hh_elementary/common/navigation_helper.dart';
import 'package:test_task_hh_elementary/tasks/domain/entity/task.dart';
import 'package:test_task_hh_elementary/tasks/presentation/details/task_details_page.dart';
import 'package:test_task_hh_elementary/tasks/presentation/list/tasks_list_model.dart';
import 'package:test_task_hh_elementary/tasks/presentation/list/tasks_list_page.dart';

abstract class ITasksListWm implements IWidgetModel {
  ValueListenable<List<Task>> get tasks;

  void changeTaskStatus({required Task task, required bool value});

  void showCreateTaskBottomSheet({
    required ShapeBorder border,
    required Widget body,
  });

  void createTask({required String title, required String description});

  void navigateToDetails(Task task);

  void replaceChangedTask({
    required Task oldTask,
    required Task newTask,
  });

  void deleteTask(Task task);
}

TasksListWm createTaskListWm(BuildContext _) => TasksListWm(
      TasksListModel(),
      NavigationHelper(),
    );

class TasksListWm extends WidgetModel<TasksListPage, TasksListModel>
    implements ITasksListWm {
  final NavigationHelper _navigationHelper;

  TasksListWm(TasksListModel model, this._navigationHelper) : super(model);

  @override
  ValueListenable<List<Task>> get tasks => model.tasks;

  @override
  void changeTaskStatus({required Task task, required bool value}) {
    final chosenTaskIndex = model.tasks.value.indexOf(task);
    final changedTask = task.copyWith(isActive: !value);

    List<Task> taskListToModify = List.from(model.tasks.value);

    taskListToModify
        .replaceRange(chosenTaskIndex, chosenTaskIndex + 1, [changedTask]);

    model.tasks.value = taskListToModify;
  }

  @override
  void showCreateTaskBottomSheet({
    required ShapeBorder border,
    required Widget body,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      shape: border,
      builder: (builderContext) {
        return body;
      },
    );
  }

  @override
  void createTask({required String title, required String description}) {
    final newTask = Task(
      title: title,
      description: description,
      isActive: true,
    );

    List<Task> taskListToModify = List.from(model.tasks.value);

    taskListToModify.insert(0, newTask);

    model.tasks.value = taskListToModify;

    _navigationHelper.pop(context);
  }

  @override
  void navigateToDetails(Task task) {
    _navigationHelper
        .push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailsPage(task: task),
      ),
    )
        .then((value) {
      if (value is Task) {
        replaceChangedTask(oldTask: task, newTask: value);
      }

      if (value is bool && value == true) {
        deleteTask(task);
      }
    });
  }

  @override
  void replaceChangedTask({required Task oldTask, required Task newTask}) {
    final taskIndex = model.tasks.value.indexOf(oldTask);

    List<Task> taskListToModify = List.from(model.tasks.value);

    taskListToModify.replaceRange(taskIndex, taskIndex + 1, [newTask]);

    model.tasks.value = taskListToModify;
  }

  @override
  void deleteTask(Task task) {
    List<Task> taskListToModify = List.from(model.tasks.value);

    taskListToModify.remove(task);

    model.tasks.value = taskListToModify;
  }
}
