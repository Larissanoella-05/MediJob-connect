class Job {
  final String id;
  final String title;
  final String description;
  final String company;
  final String location;
  final String salaryRange;
  final String jobType;
  final String experienceLevel;
  final List<String> requirements;
  final List<String> benefits;
  final String contactEmail;
  final DateTime postedDate;
  final DateTime? deadline;
  final bool isActive;

  const Job({
    required this.id,
    required this.title,
    required this.description,
    required this.company,
    required this.location,
    required this.salaryRange,
    required this.jobType,
    required this.experienceLevel,
    required this.requirements,
    required this.benefits,
    required this.contactEmail,
    required this.postedDate,
    this.deadline,
    required this.isActive,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Job && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}