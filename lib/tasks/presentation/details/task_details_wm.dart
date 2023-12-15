import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_task_hh_elementary/common/navigation_helper.dart';
import 'package:test_task_hh_elementary/tasks/presentation/details/task_details_model.dart';
import 'package:test_task_hh_elementary/tasks/presentation/details/task_details_page.dart';

abstract class ITaskDetailsWm implements IWidgetModel {
  ValueListenable<TaskDetailsListenableModel> get data;

  TextEditingController get titleController;

  TextEditingController get descriptionController;

  void editTask();

  void cancelEditing();

  void saveChanges();

  void changeTaskStatus();

  void toPreviousPage({bool toDelete});
}

TaskDetailsWm createTaskDetailsWm(BuildContext _) => TaskDetailsWm(
      TaskDetailsModel(),
      NavigationHelper(),
    );

class TaskDetailsWm extends WidgetModel<TaskDetailsPage, TaskDetailsModel>
    implements ITaskDetailsWm {
  final NavigationHelper _navigationHelper;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  TaskDetailsWm(TaskDetailsModel model, this._navigationHelper) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    model.data.value = model.data.value.copyWith(task: widget.task);
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
  }

  @override
  TextEditingController get titleController => _titleController;

  @override
  TextEditingController get descriptionController => _descriptionController;

  @override
  ValueListenable<TaskDetailsListenableModel> get data => model.data;

  @override
  void editTask() {
    model.data.value =
        model.data.value.copyWith(shouldEdit: !model.data.value.shouldEdit);
  }

  @override
  void cancelEditing() {
    _titleController.text = model.data.value.task.title;
    _descriptionController.text = model.data.value.task.description;

    editTask();
  }

  @override
  void saveChanges() {
    model.data.value = model.data.value.copyWith(
      task: model.data.value.task.copyWith(
          title: _titleController.text,
          description: _descriptionController.text),
    );

    editTask();
  }

  @override
  void changeTaskStatus() {
    model.data.value = model.data.value.copyWith(
      task: model.data.value.task.copyWith(
        isActive: !model.data.value.task.isActive,
      ),
    );
  }

  @override
  void toPreviousPage({bool toDelete = false}) {
    _navigationHelper.pop(context, toDelete ? true : model.data.value.task);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }
}
