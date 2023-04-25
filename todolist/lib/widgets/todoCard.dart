import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class todoCard extends StatefulWidget {
  String title;
  String description;
  bool isChecked;

  Function()? onPressedDelete;
  Function()? onPressedEdit;
  Function(bool?)? onChanged;

  todoCard(
      {super.key,
      required this.title,
      required this.description,
      required this.onPressedDelete,
      required this.onPressedEdit,
      required this.isChecked,
      required this.onChanged});

  @override
  State<todoCard> createState() => _todoCardState();
}

class _todoCardState extends State<todoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Checkbox(value: widget.isChecked, onChanged: widget.onChanged),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(widget.title), Text(widget.description)],
            ),
          ),
          IconButton(
            onPressed: widget.onPressedEdit,
            icon: Icon(Icons.edit),
          ),
          IconButton(
              onPressed: widget.onPressedDelete, icon: Icon(Icons.delete))
        ],
      ),
    );
  }
}
