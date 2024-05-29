import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  final String title;
  final String content;

  final void Function()? onEdit;
  final void Function()? onDelete;

  const NoteTile({
    Key? key,
    required this.title,
    required this.content,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          maxLines: 1, // Limit to one line
          overflow: TextOverflow.ellipsis, // Show ellipsis if text overflows
        ),
        subtitle: Text(
          content,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          overflow: TextOverflow.ellipsis, // Show ellipsis if text overflows
          maxLines: 1, // Limit to one line
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onEdit != null)
              IconButton(
                icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.inversePrimary),
                onPressed: onEdit,
              ),
            if (onDelete != null)
              IconButton(
                icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.inversePrimary),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}
