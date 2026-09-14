import 'package:flutter/material.dart';

class AssignmentListScreen extends StatefulWidget {
  const AssignmentListScreen({super.key});

  @override
  State<AssignmentListScreen> createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends State<AssignmentListScreen> {
  final List<Map<String, dynamic>> assignments = [];

  void _showAddAssignmentDialog(BuildContext context) {
  String title = '';
  String description = '';
  DateTime? dueDate;

    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add Assignment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              onChanged: (value) {
                title = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                description = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Due Date (YYYY-MM-DD)'),
              onChanged: (value) {
                dueDate = DateTime.tryParse(value);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (title.isNotEmpty && description.isNotEmpty && dueDate != null) {
                setState(() {
                  assignments.add({
                    'title': title,
                    'description': description,
                    'dueDate': dueDate,
                  });
                });
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
    );
  }

  void _toggleAssignmentCompletion(int index, bool? value) {
    setState(() {
      assignments[index]['completed'] = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text('Assignments'),
    ),
    body: ListView.builder(
      itemCount: assignments.length,
      itemBuilder: (context, index) {
        final assignment = assignments[index];
        return ListTile(
          title: Text(assignment['title']),
          subtitle: Text(assignment['description']),
          trailing: Checkbox(
            value: assignment['completed'] ?? false,
            onChanged: (value) {
              _toggleAssignmentCompletion(index, value);
            },
          ),
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => _showAddAssignmentDialog(context),
      child: const Icon(Icons.add),
    ),
    );
  }
}
