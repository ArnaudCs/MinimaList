import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minimalist/services/task_service.dart';
import 'package:minimalist/src/sample_feature/list_item.dart';
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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Minima',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Serif',
                fontWeight: FontWeight.w900
              ),
            ),
            SizedBox(width: 4),
            Text(
              'List',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Serif',
                fontWeight: FontWeight.w400
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
                      if (direction == DismissDirection.endToStart) {
                        await _taskService.completeTask(item.id);
                        setState(() {
                          items.removeAt(index); 
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Task completed, good job', 
                                  style: TextStyle(
                                    fontFamily: 'Serif',
                                    color: Colors.white
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.verified_outlined, color: Colors.white),
                              ],
                            ),
                            backgroundColor: Colors.green[400],
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)
                              )
                            ),
                          )
                        );
                      } else if (direction == DismissDirection.startToEnd) {
                        await _taskService.removeTask(item.id); 
                        setState(() {
                          items.removeAt(index);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Task deleted',
                                  style: TextStyle(
                                    fontFamily: 'Serif',
                                    color: Colors.white
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.delete_outlined, color: Colors.white)
                              ],
                            ),
                            backgroundColor: Colors.red[400],
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)
                              )
                            ),
                          )
                        );
                      }
                    },
                    background: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.delete_outlined, color: Colors.white)
                          ),
                        ),
                      ),
                    ),
                    secondaryBackground: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.verified_outlined, color: Colors.white)
                          ),
                        ),
                      ),
                    ),
                    key: Key(item.id.toString()),
                    child: ListItem(taskName: item.taskName),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openTaskCreationModal, // Open the modal on button press
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
