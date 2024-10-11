import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  final String taskName;

  const ListItem({
    super.key,
    required this.taskName,
  });

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(
                Icons.expand_circle_down_outlined,
                color: Theme.of(context).appBarTheme.titleTextStyle?.color,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.taskName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 18,
                    color: Theme.of(context).appBarTheme.titleTextStyle?.color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}