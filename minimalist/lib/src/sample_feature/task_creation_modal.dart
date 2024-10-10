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
    double screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Réduction de l'arrondi
      ),
      child: Container(
        width: screenWidth * 0.95, // 95% de la largeur de l'écran
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ajuste la taille à son contenu
          children: [
            const Text(
              'Create New Task',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Serif',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _taskNameController,
              cursorColor: Colors.grey,
              maxLength: 30,
              maxLines: 1,
              style: const TextStyle(
                fontFamily: 'Serif',
              ),
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: 'Task Name',
                hintText: 'Enter the name of the task',
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Serif'
                ),
                helperStyle: const TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Serif',
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey), 
                  borderRadius: BorderRadius.circular(8), 
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey), 
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Fermer la modal sans ajouter de tâche
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Serif',
                      fontSize: 16,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Add Task',
                    style: TextStyle(
                      fontFamily: 'Serif',
                      fontSize: 16,
                    )
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
