import 'package:flutter/material.dart';
import 'jobs_page.dart';

class JobDetailsPage extends StatelessWidget {
  final Job job;

  const JobDetailsPage({super.key, required this.job});

  void _onApply(BuildContext context) {
    // UI feedback for now — later replace with real apply flow (Firebase / API)
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm application'),
          content: Text('Do you want to apply to "${job.title}" at ${job.company}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // cancel
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // close dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Application submitted for "${job.title}"')),
                );
                // TODO: call your apply usecase / backend here
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company avatar placeholder
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
          ),
          child: const Icon(Icons.local_hospital, size: 36),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(job.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(job.company, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 6),
              Text('${job.location} • ${job.type} • ${job.postedAt}', style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Job description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Text(job.description),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () => _onApply(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Apply for this job', style: TextStyle(fontSize: 16)),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildDescription(),
            const SizedBox(height: 24),
            const Text('How to prepare', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text('• Attach a concise CV\n• Include a short cover note explaining motivation\n• Highlight relevant certifications'),
            const SizedBox(height: 24),
            const Text('Contact', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text('For queries about this role, contact the hiring team through the app after application.'),
          ],
        ),
      ),
    );
  }
}
