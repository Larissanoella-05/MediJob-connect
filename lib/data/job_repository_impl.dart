// File: lib/data/repositories/job_repository_impl.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../datasources/remote/firestore_remote_datasource.dart';
import '../../domain/entities/job.dart';
import '../../domain/repositories/job_repository.dart';

class JobRepositoryImpl implements JobRepository {
  final FirestoreRemoteDataSource remoteDataSource;

  JobRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Job>> getJobs() async {
    final docs = await remoteDataSource.fetchJobs();
    return docs.map((doc) => Job.fromMap(doc.data())).toList();
  }

  @override
  Future<void> applyToJob(String jobId, String userId) async {
    await remoteDataSource.applyToJob(jobId: jobId, userId: userId);
  }
}
