import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_task_hh_elementary/tasks/domain/entity/task.dart';

const _mockedTasks = [
  Task(
    title: 'First task',
    description: 'Need to fix car',
    isActive: true,
  ),
  Task(
    title: 'Second task',
    description: 'Need to fix door',
    isActive: true,
  ),
  Task(
    title: 'Third task',
    description: 'Need to meet with parents',
    isActive: false,
  ),
  Task(
    title: 'Fourth task',
    description: 'Need to fix several bugs',
    isActive: true,
  ),
  Task(
    title: 'Fifth task',
    description: 'Need to fix finish test task',
    isActive: false,
  ),
];

class TasksListModel extends ElementaryModel {
  final ValueNotifier<List<Task>> tasks = ValueNotifier(_mockedTasks);
}
