import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:test_task_hh_elementary/common/common_size.dart';
import 'package:test_task_hh_elementary/tasks/domain/entity/task.dart';
import 'package:test_task_hh_elementary/tasks/presentation/list/tasks_list_wm.dart';
import 'package:test_task_hh_elementary/tasks/presentation/list/widgets/create_task_bottom_sheet.dart';
import 'package:test_task_hh_elementary/tasks/presentation/list/widgets/tasks_list_content.dart';

const _tabBarLength = 2;

class TasksListPage extends ElementaryWidget<ITasksListWm> {
  const TasksListPage({
    Key? key,
    WidgetModelFactory wmFactory = createTaskListWm,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ITasksListWm wm) {
    return DefaultTabController(
      length: _tabBarLength,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.deepPurple,
            tabs: [
              Tab(text: 'Активные'),
              Tab(text: 'Завершенные'),
            ],
          ),
        ),
        body: ValueListenableBuilder<List<Task>>(
          valueListenable: wm.tasks,
          builder: (_, data, __) {
            final activeTasks = data.where((e) => e.isActive).toList();
            final nonActiveTasks = data.where((e) => !e.isActive).toList();

            return TabBarView(
              children: [
                TasksListContent(
                  tasks: activeTasks,
                  onChangeTaskStatus: (task, value) =>
                      wm.changeTaskStatus(task: task, value: value),
                  navigateToDetails: (task) => wm.navigateToDetails(task),
                ),
                TasksListContent(
                  tasks: nonActiveTasks,
                  onChangeTaskStatus: (task, value) =>
                      wm.changeTaskStatus(task: task, value: value),
                  navigateToDetails: (task) => wm.navigateToDetails(task),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => wm.showCreateTaskBottomSheet(
            border: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(CommonSize.defaultRadius),
                topRight: Radius.circular(CommonSize.defaultRadius),
              ),
            ),
            body: CreateTaskBottomSheet(
              onCreate: (title, description) => wm.createTask(
                title: title,
                description: description,
              ),
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
