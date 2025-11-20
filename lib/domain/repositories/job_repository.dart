import '../entities/job.dart';
import '../entities/application.dart';

abstract class JobRepository {
  Future<List<Job>> getJobs({String? searchQuery, String? location, String? jobType});
  Future<Job> getJobById(String jobId);
  Future<List<Job>> getFavoriteJobs(String userId);
  Future<void> addToFavorites(String userId, String jobId);
  Future<void> removeFromFavorites(String userId, String jobId);
  Future<Application> applyToJob(String userId, String jobId, String coverLetter, String? resumeUrl);
  Future<List<Application>> getUserApplications(String userId);
  Future<Application> getApplicationById(String applicationId);
}