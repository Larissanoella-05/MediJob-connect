import '../entities/application.dart';
import '../repositories/job_repository.dart';

class ApplyToJobParams {
  final String userId;
  final String jobId;
  final String coverLetter;
  final String? resumeUrl;

  const ApplyToJobParams({
    required this.userId,
    required this.jobId,
    required this.coverLetter,
    this.resumeUrl,
  });
}

class ApplyToJob {
  final JobRepository repository;

  const ApplyToJob(this.repository);

  Future<Application> call(ApplyToJobParams params) async {
    return await repository.applyToJob(
      params.userId,
      params.jobId,
      params.coverLetter,
      params.resumeUrl,
    );
  }
}