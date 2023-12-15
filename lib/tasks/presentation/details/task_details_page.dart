import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:test_task_hh_elementary/common/common_size.dart';
import 'package:test_task_hh_elementary/tasks/domain/entity/task.dart';
import 'package:test_task_hh_elementary/tasks/presentation/details/task_details_wm.dart';

class TaskDetailsPage extends ElementaryWidget<ITaskDetailsWm> {
  final Task task;

  const TaskDetailsPage({
    Key? key,
    WidgetModelFactory wmFactory = createTaskDetailsWm,
    required this.task,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ITaskDetailsWm wm) {
    return ValueListenableBuilder(
      valueListenable: wm.data,
      builder: (_, data, __) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => wm.toPreviousPage(),
            ),
            title: Text(data.task.title),
            actions: [
              if (data.shouldEdit)
                IconButton(
                  onPressed: () => wm.editTask(),
                  icon: const Icon(Icons.edit),
                ),
              if (!data.shouldEdit) ...[
                IconButton(
                  onPressed: () => wm.saveChanges(),
                  icon: const Icon(Icons.check),
                ),
                IconButton(
                  onPressed: () => wm.cancelEditing(),
                  icon: const Icon(Icons.clear),
                ),
              ],
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: CommonSize.paddingDefault,
              vertical: CommonSize.paddingDoubleDefault,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        enabled: !data.shouldEdit,
                        controller: wm.titleController,
                        decoration:
                            const InputDecoration(labelText: 'Заголовок'),
                      ),
                      const SizedBox(height: CommonSize.paddingDefault),
                      TextField(
                        enabled: !data.shouldEdit,
                        controller: wm.descriptionController,
                        decoration:
                            const InputDecoration(labelText: 'Описание'),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => wm.changeTaskStatus(),
                        style: const ButtonStyle().copyWith(
                          padding: const MaterialStatePropertyAll(
                            EdgeInsets.all(CommonSize.paddingDefault),
                          ),
                        ),
                        child: Text(
                          data.task.isActive ? 'Завершить' : 'Активировать',
                        ),
                      ),
                    ),
                    const SizedBox(width: CommonSize.paddingDefault),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => wm.toPreviousPage(toDelete: true),
                        style: const ButtonStyle().copyWith(
                          padding: const MaterialStatePropertyAll(
                            EdgeInsets.all(CommonSize.paddingDefault),
                          ),
                        ),
                        child: const Text('Удалить'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
