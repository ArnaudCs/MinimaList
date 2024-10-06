import 'package:minimalist/src/sample_feature/sample_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TaskService {
  static const String _taskKey = 'tasks';

  /// Fetch all tasks from SharedPreferences
  Future<List<SampleItem>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskString = prefs.getString(_taskKey);
    
    if (taskString != null) {
      List<dynamic> decodedTasks = jsonDecode(taskString);
      return decodedTasks.map((item) => SampleItem.fromJson(item)).toList();
    }
    return [];
  }

  /// Save tasks to SharedPreferences
  Future<void> saveTasks(List<SampleItem> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskString = jsonEncode(tasks.map((e) => e.toJson()).toList());
    await prefs.setString(_taskKey, taskString);
  }

  /// Add a new task
  Future<void> addTask(SampleItem task) async {
    List<SampleItem> tasks = await getTasks();
    tasks.add(task);
    await saveTasks(tasks);
  }

  /// Remove a task by id
  Future<void> removeTask(int id) async {
    List<SampleItem> tasks = await getTasks();
    tasks.removeWhere((task) => task.id == id);
    await saveTasks(tasks);
  }
}
