import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volun/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:volun/models/job_model.dart";
import "package:uuid/uuid.dart";
import "package:volun/models/user_model.dart" as user_model;

class CrudMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _jobsCollectionName = "jobs";

  Future<Job> getJob(id) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("jobs").doc(id).get();
    return Job.fromSnap(documentSnapshot);
  }

  Future<String> addJob({
    required Uint8List file,
    required String jobTitle,
    required String details,
    required String eligibilty,
    required String jobType,
  }) async {
    String res = "Some error occurred";
    Uuid uuid = const Uuid();
    User currentUser = _auth.currentUser!;
    try {
      if (jobTitle.isNotEmpty && details.isNotEmpty) {
        String photoUrl =
            await StorageMethods().uploadImageToStorage("jobPics", file);
        DocumentSnapshot userSnap =
            await _firestore.collection("users").doc(currentUser.uid).get();
        user_model.User company = user_model.User.fromSnap(userSnap);
        Job job = Job(
          uid: uuid.v4(),
          photoUrl: photoUrl,
          jobTitle: jobTitle,
          company: company,
          details: details,
          eligibilty: eligibilty,
          jobType: jobType,
          applied: [],
        );

        await _firestore
            .collection(_jobsCollectionName)
            .doc(job.uid)
            .set(job.toJson());
        res = "success";
      } else {
        res = "Please enter all fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> editJob({
    required String jobId,
    required String jobTitle,
    required String details,
    required String eligibilty,
    required String jobType,
    Uint8List? file,
    String? photoURL,
  }) async {
    String res = "Some error occurred";
    Uuid uuid = const Uuid();
    User currentUser = _auth.currentUser!;
    try {
      if (jobTitle.isNotEmpty && details.isNotEmpty) {
        String photoUrl = file == null
            ? photoURL!
            : await StorageMethods().uploadImageToStorage("jobPics", file);
        DocumentSnapshot userSnap =
            await _firestore.collection("users").doc(currentUser.uid).get();
        user_model.User company = user_model.User.fromSnap(userSnap);
        Job job = Job(
          uid: jobId,
          photoUrl: photoUrl,
          jobTitle: jobTitle,
          company: company,
          details: details,
          eligibilty: eligibilty,
          jobType: jobType,
          applied: [],
        );

        await _firestore
            .collection(_jobsCollectionName)
            .doc(job.uid)
            .set(job.toJson());
        res = "success";
      } else {
        res = "Please enter all fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> applyToJob({required String jobId}) async {
    String res = "Something has occurred";
    User currentUser = _auth.currentUser!;
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection(_jobsCollectionName).doc(jobId).get();
      DocumentSnapshot userSnapshot =
          await _firestore.collection("users").doc(currentUser.uid).get();
      user_model.User uesrData = user_model.User.fromSnap(userSnapshot);
      Job job = Job.fromSnap(documentSnapshot);
      List<Map<String, dynamic>> applied = job.toJson()["applied"];
      applied.add(uesrData.toJson());
      documentSnapshot.reference.update(<String, dynamic>{
        "applied": applied,
      });
      res = 'success';
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<List<Job>> getAllJobs() async {
    QuerySnapshot<Map<String, dynamic>> documentSnapshot =
        await _firestore.collection(_jobsCollectionName).get();
    List<Job> snapshot = documentSnapshot.docs
        .map((doc) => doc.data())
        .map((doc) => Job.fromJson(doc))
        .toList();
    return snapshot;
  }

  Future<String> removeJob({required String jobId}) async {
    String res = "An error occurred";
    try {
      await _firestore.collection(_jobsCollectionName).doc(jobId).delete();
      res = "success";
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
