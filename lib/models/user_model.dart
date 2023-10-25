import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String photoUrl;
  String name;
  String email;
  String type;
  String phone;
  String address;
  String age;
  String qualification;

  User({
    required this.uid,
    required this.photoUrl,
    required this.name,
    required this.email,
    required this.type,
    required this.phone,
    required this.address,
    required this.age,
    required this.qualification,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "photoUrl": photoUrl,
        "name": name,
        "email": email,
        "type": type,
        "phone": phone,
        "address": address,
        "age": age,
        "qualification": qualification,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      uid: snapshot["uid"],
      photoUrl: snapshot["photoUrl"],
      name: snapshot["name"],
      email: snapshot["email"],
      type: snapshot['type'],
      phone: snapshot["phone"],
      address: snapshot["address"],
      age: snapshot["age"],
      qualification: snapshot["qualification"],
    );
  }

  static User fromJson(Map<String, dynamic> jsonData) {
    return User(
      uid: jsonData["uid"],
      photoUrl: jsonData["photoUrl"],
      name: jsonData["name"],
      email: jsonData["email"],
      type: jsonData['type'],
      phone: jsonData["phone"],
      address: jsonData["address"],
      age: jsonData["age"],
      qualification: jsonData["qualification"],
    );
  }
}
