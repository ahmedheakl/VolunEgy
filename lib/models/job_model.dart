import 'package:cloud_firestore/cloud_firestore.dart';
import "package:volun/models/user_model.dart" as user_model;

class Job {
  String uid;
  String photoUrl;
  String jobTitle;
  user_model.User company;
  String details;
  String eligibilty;
  String jobType;
  List<user_model.User> applied;

  Job({
    required this.uid,
    required this.photoUrl,
    required this.jobTitle,
    required this.company,
    required this.details,
    required this.eligibilty,
    required this.jobType,
    required this.applied,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> appliedUser = [];
    for (user_model.User user in applied) {
      appliedUser.add(user.toJson());
    }
    return {
      "uid": uid,
      "photoUrl": photoUrl,
      "jobTitle": jobTitle,
      "company": company.toJson(),
      "details": details,
      "eligibilty": eligibilty,
      "jobType": jobType,
      "applied": appliedUser,
    };
  }

  static Job fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    List<user_model.User> appliedUsers = [];
    for (var userData in snapshot["applied"]) {
      appliedUsers.add(user_model.User.fromJson(userData));
    }
    return Job(
      uid: snapshot["uid"],
      photoUrl: snapshot["photoUrl"],
      jobTitle: snapshot["jobTitle"],
      company: user_model.User.fromJson(snapshot["company"]),
      details: snapshot['details'],
      eligibilty: snapshot['eligibilty'],
      jobType: snapshot["jobType"],
      applied: appliedUsers,
    );
  }

  static Job fromJson(Map<String, dynamic> jobData) {
    List<user_model.User> appliedUsers = [];
    for (var userData in jobData["applied"]) {
      appliedUsers.add(user_model.User.fromJson(userData));
    }
    return Job(
      uid: jobData["uid"],
      photoUrl: jobData["photoUrl"],
      jobTitle: jobData["jobTitle"],
      company: user_model.User.fromJson(jobData["company"]),
      details: jobData['details'],
      eligibilty: jobData['eligibilty'],
      jobType: jobData["jobType"],
      applied: appliedUsers,
    );
  }
}
