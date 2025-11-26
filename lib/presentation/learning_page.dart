import 'package:flutter/material.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Make the list local inside build to avoid const/StatelessWidget conflict
    final List<Map<String, String>> courses = [
      {'title': 'Basic Life Support', 'description': 'Learn CPR and first aid basics.'},
      {'title': 'Medical Terminology', 'description': 'Understand key medical terms.'},
      {'title': 'Patient Care', 'description': 'Techniques to improve patient care.'},
      {'title': 'Pharmacy Basics', 'description': 'Introduction to medications.'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Learning')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(course['title']!),
              subtitle: Text(course['description']!),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Open course: ${course['title']}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
