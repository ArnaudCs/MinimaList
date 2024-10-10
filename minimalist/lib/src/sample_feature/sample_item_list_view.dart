import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minimalist/services/task_service.dart';
import 'package:minimalist/src/sample_feature/sample_item.dart';
import 'package:minimalist/src/sample_feature/task_creation_modal.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                fontSize: 30,
                color: Colors.grey[200],
                fontWeight: FontWeight.w900
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'List',
              style: TextStyle(
                fontSize: 30,
                color: Colors.grey[200],
                fontWeight: FontWeight.w500
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings_outlined
            ),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: items.isEmpty
            ? Center(
                child: SvgPicture.asset(
                  'lib/assets/noTask.svg',
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: Colors.grey.withOpacity(0.2),
                ),
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
                    background: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    secondaryBackground: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
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
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.task, color: Colors.white,),
                                  const SizedBox(width: 8),
                                  Text(
                                    item.taskName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                      fontSize: 20,
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
