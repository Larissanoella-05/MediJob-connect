import '../entities/job.dart';
import '../repositories/job_repository.dart';

class GetJobsParams {
  final String? searchQuery;
  final String? location;
  final String? jobType;

  const GetJobsParams({
    this.searchQuery,
    this.location,
    this.jobType,
  });
}

class GetJobs {
  final JobRepository repository;

  const GetJobs(this.repository);

  Future<List<Job>> call(GetJobsParams params) async {
    return await repository.getJobs(
      searchQuery: params.searchQuery,
      location: params.location,
      jobType: params.jobType,
    );
  }
}