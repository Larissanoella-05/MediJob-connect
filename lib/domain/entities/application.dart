enum ApplicationStatus {
  pending,
  reviewing,
  accepted,
  rejected,
  withdrawn,
}

class Application {
  final String id;
  final String userId;
  final String jobId;
  final String coverLetter;
  final String? resumeUrl;
  final ApplicationStatus status;
  final DateTime appliedDate;
  final DateTime? reviewedDate;
  final String? reviewNotes;

  const Application({
    required this.id,
    required this.userId,
    required this.jobId,
    required this.coverLetter,
    this.resumeUrl,
    required this.status,
    required this.appliedDate,
    this.reviewedDate,
    this.reviewNotes,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Application && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}