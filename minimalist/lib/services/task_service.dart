import 'dart:ffi';
import 'package:minimalist/src/sample_feature/sample_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TaskService {
  static const String _taskKey = 'tasks';
  static const String _completedTasksKey = 'completed_tasks';

  Future<List<SampleItem>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskString = prefs.getString(_taskKey);

    if (taskString != null) {
      List<dynamic> decodedTasks = jsonDecode(taskString);
      return decodedTasks.map((item) => SampleItem.fromJson(item)).toList();
    }
    return [];
  }

  Future<void> saveTasks(List<SampleItem> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskString = jsonEncode(tasks.map((e) => e.toJson()).toList());
    await prefs.setString(_taskKey, taskString);
  }

  Future<void> addTask(SampleItem task) async {
    List<SampleItem> tasks = await getTasks();
    tasks.add(task);
    await saveTasks(tasks);
  }

  Future<void> removeTask(int id) async {
    List<SampleItem> tasks = await getTasks();
    tasks.removeWhere((task) => task.id == id);
    await saveTasks(tasks);
  }

  Future<void> completeTask(int id) async {
    List<SampleItem> tasks = await getTasks();
    for (var task in tasks) {
      if (task.id == id) {
        task.isDone = true; 
        break;
      }
    }

    await removeTask(id);
    await _incrementCompletedTaskCount();
  }

  Future<int> getCompletedTaskCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_completedTasksKey) ?? 0; 
  }

  Future<void> _incrementCompletedTaskCount() async {
    final prefs = await SharedPreferences.getInstance();
    int currentCount = await getCompletedTaskCount();
    await prefs.setInt(_completedTasksKey, currentCount + 1);
  }
}
