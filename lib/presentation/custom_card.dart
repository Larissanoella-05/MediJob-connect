import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String location;
  final String type;
  final String hospital;

  const JobCard({
    super.key,
    required this.title,
    required this.location,
    required this.type,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset('assets/images/hospital.png', width: 40),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(hospital),
            Text('$location • $type'),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          child: const Text('Apply'),
        ),
      ),
    );
  }
}
