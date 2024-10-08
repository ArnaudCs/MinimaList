import 'package:flutter/material.dart';
import 'package:minimalist/services/task_service.dart';
import 'package:minimalist/src/sample_feature/sample_item.dart';


class TaskCreationModal extends StatefulWidget {
  final Function onTaskAdded;

  const TaskCreationModal({Key? key, required this.onTaskAdded}) : super(key: key);

  @override
  _TaskCreationModalState createState() => _TaskCreationModalState();
}

class _TaskCreationModalState extends State<TaskCreationModal> {
  final TextEditingController _taskNameController = TextEditingController();
  final TaskService _taskService = TaskService();

  @override
  void dispose() {
    _taskNameController.dispose();
    super.dispose();
  }

  void _addTask() async {
    String taskName = _taskNameController.text.trim();

    if (taskName.isNotEmpty) {
      int newTaskId = DateTime.now().millisecondsSinceEpoch;
      SampleItem newTask = SampleItem(newTaskId, taskName: taskName);

      await _taskService.addTask(newTask);

      widget.onTaskAdded();

      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task name cannot be empty'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Task'),
      content: TextField(
        controller: _taskNameController,
        maxLength: 40,
        maxLines: 1,
        decoration: const InputDecoration(
          labelText: 'Task Name',
          hintText: 'Enter the name of the task',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close modal without saving
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _addTask,
          child: const Text('Add Task'),
        ),
      ],
    );
  }
}
