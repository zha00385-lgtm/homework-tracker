import 'package:flutter/material.dart';

class AssignmentListScreen extends StatefulWidget {
  const AssignmentListScreen({super.key});

  @override
  State<AssignmentListScreen> createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends State<AssignmentListScreen> {
  final List<Map<String, dynamic>> assignments = [];

  void _showAssignmentDialog(BuildContext context, {int? index}) {
    final isEditing = index != null;
    
    // Use controllers to pre-fill data if editing an existing assignment
    final titleController = TextEditingController(
        text: isEditing ? assignments[index]['title'] : '');
    final descriptionController = TextEditingController(
        text: isEditing ? assignments[index]['description'] : '');
    final dueDateController = TextEditingController(
        text: isEditing && assignments[index]['dueDate'] != null
            ? (assignments[index]['dueDate'] as DateTime).toIso8601String().split('T').first
            : '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Assignment' : 'Add Assignment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: dueDateController,
                decoration: const InputDecoration(labelText: 'Due Date (YYYY-MM-DD)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                  final parsedDate = DateTime.tryParse(dueDateController.text);
                  
                  setState(() {
                    final newAssignment = {
                      'title': titleController.text,
                      'description': descriptionController.text,
                      'dueDate': parsedDate,
                      'completed': isEditing ? assignments[index]['completed'] : false,
                    };

                    if (isEditing) {
                      assignments[index] = newAssignment; // Update existing
                    } else {
                      assignments.add(newAssignment); // Add new
                    }
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text(isEditing ? 'Save' : 'Add'),
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

  void _deleteAssignment(int index) {
    setState(() {
      assignments.removeAt(index);
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
            leading: Checkbox(
              value: assignment['completed'] ?? false,
              onChanged: (value) => _toggleAssignmentCompletion(index, value),
            ),
            title: Text(assignment['title']),
            subtitle: Text(assignment['description']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _showAssignmentDialog(context, index: index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteAssignment(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAssignmentDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}