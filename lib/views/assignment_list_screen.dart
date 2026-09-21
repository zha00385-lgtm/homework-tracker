import 'package:flutter/material.dart';

class Assignment {
  Assignment({
    required this.title,
    required this.description,
    required this.dueDate,
  });

  final String title;
  final String description;
  final DateTime dueDate;
  bool isCompleted = false;
}

class AssignmentPresenter {
  final List<Assignment> assignments = [];

  void addAssignment(String title, String description, DateTime dueDate) {
    assignments.add(
      Assignment(title: title, description: description, dueDate: dueDate),
    );
  }
}

class AssignmentListScreen extends StatefulWidget {
  const AssignmentListScreen({super.key});

  @override
  State<AssignmentListScreen> createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends State<AssignmentListScreen> {
  final AssignmentPresenter _presenter = AssignmentPresenter();

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
                  _presenter.addAssignment(title.trim(), description.trim(), dueDate!);
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
      _presenter.assignments[index].isCompleted = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final assignments = _presenter.assignments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
      ),
      body: ListView.builder(
        itemCount: assignments.length,
        itemBuilder: (context, index) {
          final assignment = assignments[index];
          return ListTile(
           title: Text(
              assignment.title,
              style: TextStyle(
                decoration: assignment.isCompleted ? TextDecoration.lineThrough : null,
                color: assignment.isCompleted ? Colors.grey : null,
                fontStyle: assignment.isCompleted ? FontStyle.italic : FontStyle.normal,
              ),
            ),
            trailing: Checkbox(
              value: assignment.isCompleted,
              onChanged: (value) {
                _toggleAssignmentCompletion(index, value);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAssignmentDialog(context),
        tooltip: 'Add assignment',
        child: const Icon(Icons.add),
      ),
    );
}
}