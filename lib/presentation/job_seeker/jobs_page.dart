import 'package:flutter/material.dart';
import 'job_details_page.dart';

/// Simple local Job model used by the Jobs UI.
/// You can replace this with your domain entity later (lib/domain/entities/job.dart).
class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String description;
  final String type; // e.g. Full-time, Internship
  final String postedAt; // human-friendly date

  const Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    required this.type,
    required this.postedAt,
  });
}

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  // Temporary job list (will be replaced with backend/Firebase later)
  static const List<Job> _jobs = [
    Job(
      id: 'job_001',
      title: 'Nurse Assistant',
      company: 'Rwanda Medical Center',
      location: 'Kigali, Rwanda',
      description:
          'Support nursing staff with patient care, vitals monitoring and basic procedures. '
          'Ideal for recent nursing graduates or certificate holders.',
      type: 'Full-time',
      postedAt: '3 days ago',
    ),
    Job(
      id: 'job_002',
      title: 'Pharmacy Intern',
      company: 'Nairobi Health Group',
      location: 'Nairobi, Kenya',
      description:
          'Assist pharmacists with dispensing, inventory and patient counselling. '
          'Suitable for pharmacy students seeking hands-on experience.',
      type: 'Internship',
      postedAt: '1 week ago',
    ),
    Job(
      id: 'job_003',
      title: 'Clinical Officer',
      company: 'Kigali Heart Institute',
      location: 'Kigali, Rwanda',
      description:
          'Provide clinical assessment and treatment under supervision. Experience with basic procedures required.',
      type: 'Contract',
      postedAt: '2 weeks ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Jobs')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _jobs.length,
        itemBuilder: (context, index) {
          final job = _jobs[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => JobDetailsPage(job: job),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Leading icon / placeholder
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                      ),
                      child: const Icon(Icons.work, size: 28),
                    ),
                    const SizedBox(width: 12),

                    // Job info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.title,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 6),
                          Text(job.company),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                job.location,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                job.type,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Arrow
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
