import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatefulWidget {
  SampleItemListView({super.key});
  static const routeName = '/';
  @override
  State<SampleItemListView> createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
  List<SampleItem> items = [SampleItem(1), SampleItem(2), SampleItem(3)];

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
                color: Colors.grey[800],
                fontWeight: FontWeight.w900
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'List',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[800],
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
        child:
          items.isEmpty
            ? const Center(
                child: Text('No items'),
              )
            : ListView.builder(
              restorationId: 'sampleItemListView',
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];
        
                return Dismissible(
                  onDismissed: (direction) {
                    setState(() {
                      items.removeAt(index);
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item.id} dismissed'))
                    );
                  },
                  key: Key(item.id.toString()),  // Ensure unique keys for Dismissible
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(item.id.toString()),
                              const SizedBox(width: 8),
                              const Text('Test'),
                            ],
                          ),
                          Checkbox(
                            value: item.isDone,
                            onChanged: (value) {
                              setState(() {
                                item.isDone = value ?? false; 
                              });
                            },
                            checkColor: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Add new item');
          setState(() {
            items.add(SampleItem(items.length + 1));
          });
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
