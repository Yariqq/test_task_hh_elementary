import 'package:flutter/material.dart';
import 'package:test_task_hh_elementary/common/common_size.dart';
import 'package:test_task_hh_elementary/tasks/domain/entity/task.dart';

const _taskContainerRadius = 12.0;
const _containerShadowColorOpacity = 0.6;
const _containerShadowBlurRadius = 7.0;
const _containerShadowOffset = Offset(0, 1.0);

class TasksListContent extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task task, bool value) onChangeTaskStatus;
  final Function(Task task) navigateToDetails;

  const TasksListContent({
    required this.tasks,
    required this.onChangeTaskStatus,
    required this.navigateToDetails,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: CommonSize.paddingDefault,
        vertical: CommonSize.paddingLarge,
      ),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => navigateToDetails(tasks[index]),
                child: Container(
                  padding: const EdgeInsets.all(CommonSize.paddingDefault),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(_taskContainerRadius),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(_containerShadowColorOpacity),
                        blurRadius: _containerShadowBlurRadius,
                        offset: _containerShadowOffset,
                      ),
                    ],
                  ),
                  child: Text(
                    tasks[index].title,
                  ),
                ),
              ),
            ),
            Checkbox(
              value: !tasks[index].isActive,
              onChanged: (value) => onChangeTaskStatus(
                tasks[index],
                value ?? false,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: CommonSize.paddingDefault);
      },
    );
  }
}
