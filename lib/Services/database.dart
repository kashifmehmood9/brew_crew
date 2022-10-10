import 'dart:ffi';

import 'package:brew_crew/Models/User.dart';
import 'package:brew_crew/Screens/Home/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {
  //reference to collection
  final CollectionReference brewsCollection =
      FirebaseFirestore.instance.collection('brews');

  late String userID;

  DatabaseService({required this.userID});
  Future updateUserData(String sugars, String name, String strength) async {
    print("Updating...");
    return await brewsCollection
        .doc(userID)
        .set({'sugars': sugars, 'name': name, 'strength': strength});
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      return Brew(
          name: document["name"].toString(),
          sugars: document["sugars"].toString(),
          strength: document['strength'].toString());
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    dynamic data = snapshot.data();
    // print("name: ${data["name"]}");
    // print("name: ${data["name"]}");
    // print("sugars: ${data["sugars"]}");
    // print("strength: ${data["strength"]}");
    print("Getting data from snapshot for user $userID");

    return UserData(
        uid: userID,
        name: data["name"],
        sugars: data["sugars"],
        strength: data["strength"]);
  }

  Stream<List<Brew>> get brews {
    return brewsCollection
        .snapshots()
        .map((snapshot) => _brewListFromSnapshot(snapshot));
  }

  Stream<UserData> get userData {
    // Stream<DocumentSnapshot<Object?>> data =
    //     brewsCollection.doc(userID).snapshots();
    // print("Data is ${data.toList().}");
    // var coll = FirebaseFirestore.instance.collection(userID).doc();
    // print("User", FirebaseFirestore.instance.)
    // print(coll);
    return brewsCollection
        .doc("xsj3BmS2fQxXJDHTmawT")
        .snapshots()
        .map((_userDataFromSnapshot));
  }
}
