import 'package:flutter/material.dart';
import 'package:test_task_hh_elementary/common/common_size.dart';

class CreateTaskBottomSheet extends StatefulWidget {
  final Function(String title, String description) onCreate;

  const CreateTaskBottomSheet({required this.onCreate, super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateTaskBottomSheetState();
  }
}

class _CreateTaskBottomSheetState extends State<CreateTaskBottomSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: CommonSize.paddingDefault,
        top: CommonSize.paddingDefault,
        right: CommonSize.paddingDefault,
        bottom: CommonSize.paddingDoubleDefault,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Заголовок'),
          ),
          const SizedBox(height: CommonSize.paddingDefault),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Описание'),
          ),
          const SizedBox(height: CommonSize.paddingLarge),
          ElevatedButton(
            onPressed: () => widget.onCreate(
              _titleController.text,
              _descriptionController.text,
            ),
            style: const ButtonStyle().copyWith(
              padding: const MaterialStatePropertyAll(
                EdgeInsets.all(CommonSize.paddingDefault),
              ),
            ),
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
