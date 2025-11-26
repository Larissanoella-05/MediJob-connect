// File: lib/data/datasources/remote/firestore_remote_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreRemoteDataSource {
  Future<List<QueryDocumentSnapshot>> fetchJobs();
  Future<void> applyToJob({required String jobId, required String userId});
}

class FirestoreRemoteDataSourceImpl implements FirestoreRemoteDataSource {
  final FirebaseFirestore firestore;

  FirestoreRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<QueryDocumentSnapshot>> fetchJobs() async {
    final snapshot = await firestore.collection('jobs').get();
    return snapshot.docs;
  }

  @override
  Future<void> applyToJob(
      {required String jobId, required String userId}) async {
    final ref = firestore.collection('applications').doc();
    await ref.set({
      'jobId': jobId,
      'userId': userId,
      'appliedAt': FieldValue.serverTimestamp(),
    });
  }
}
