import 'package:flutter/material.dart';
import 'package:minimalist/services/task_service.dart';
import 'package:minimalist/src/sample_feature/sample_item.dart';
import 'package:minimalist/src/sample_feature/task_creation_modal.dart';

import '../settings/settings_view.dart';

class SampleItemListView extends StatefulWidget {
  SampleItemListView({super.key});
  static const routeName = '/';

  @override
  State<SampleItemListView> createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
  List<SampleItem> items = [];
  final TaskService _taskService = TaskService();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    List<SampleItem> loadedTasks = await _taskService.getTasks();
    setState(() {
      items = loadedTasks;
    });
  }

  void _openTaskCreationModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TaskCreationModal(onTaskAdded: _loadTasks);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 43, 34, 34),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Minima',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[200],
                fontWeight: FontWeight.w900
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'List',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[200],
                fontWeight: FontWeight.w500
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: items.isEmpty
            ? const Center(
                child: Text('No items'),
              )
            : ListView.builder(
                restorationId: 'sampleItemListView',
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = items[index];

                  return Dismissible(
                    onDismissed: (direction) async {
                      await _taskService.removeTask(item.id);
                      setState(() {
                        items.removeAt(index);
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Task completed, good job 👍'))
                      );
                    },
                    key: Key(item.id.toString()),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.task, color: Colors.white,),
                                  const SizedBox(width: 8),
                                  Text(
                                    item.taskName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openTaskCreationModal, // Open the modal on button press
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
