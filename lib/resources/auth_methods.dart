import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volun/resources/storage_methods.dart';
import 'package:volun/models/user_model.dart' as model;
import "package:volun/models/job_model.dart";

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("users").doc(currentUser.uid).get();
    return model.User.fromSnap(documentSnapshot);
  }

  Future<Job> getJob(id) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("jobs").doc(id).get();
    return Job.fromSnap(documentSnapshot);
  }

  String getCurrentUserId() {
    return _auth.currentUser!.uid;
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required Uint8List file,
    required String type,
    required String phone,
    required String address,
    required String age,
    required String qualification,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl =
            await StorageMethods().uploadImageToStorage("profilePics", file);

        model.User user = model.User(
          name: name,
          uid: cred.user!.uid,
          email: email,
          photoUrl: photoUrl,
          type: type,
          phone: phone,
          address: address,
          age: age,
          qualification: qualification,
        );

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = "success";
      } else {
        res = "Please enter all fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> editUser({
    required String email,
    required String name,
    required String type,
    required String phone,
    required String address,
    required String age,
    required String qualification,
    Uint8List? file,
    String? photoURL,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || name.isNotEmpty) {
        User currentUser = _auth.currentUser!;
        String photoUrl = file != null
            ? await StorageMethods().uploadImageToStorage("profilePics", file)
            : photoURL!;
        model.User user = model.User(
          name: name,
          uid: currentUser.uid,
          email: email,
          photoUrl: photoUrl,
          type: type,
          phone: phone,
          address: address,
          age: age,
          qualification: qualification,
        );

        await _firestore
            .collection("users")
            .doc(currentUser.uid)
            .set(user.toJson());

        res = "success";
      } else {
        res = "Please enter all fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured.";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all fields";
      }
    } catch (err) {
      return err.toString();
    }

    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
