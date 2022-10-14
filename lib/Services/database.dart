import 'package:brew_crew/Models/User.dart';
import 'package:brew_crew/Screens/Home/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //reference to collection
  final CollectionReference brewsCollection =
      FirebaseFirestore.instance.collection('brews');

  late String userID;

  DatabaseService({required this.userID});
  Future updateUserData(int sugars, String name, int strength) async {
    print("Updating records for ... $userID");
    // await FirebaseFirestore.instance
    //     .collection('brews')
    //     .doc(userID)
    print({"sugars": sugars, "name": name, "strength": strength});

    final washingtonRef = FirebaseFirestore.instance
        .collection("brews")
        .doc("one")
        .update({"name": name, "strength": strength, "sugars": sugars}).then(
            (value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) {
      print("Error updating document $e");
      FirebaseFirestore.instance
          .collection("brews")
          .doc("one")
          .set({"name": name, "strength": strength, "sugars": sugars}).then(
              (value) => print("DocumentSnapshot successfully added!"),
              onError: (e) {
        print("Error setting document $e");
      });
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      return Brew(
          name: document["name"],
          sugars: document["sugars"],
          strength: document['strength']);
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    dynamic data = snapshot.data();
    print("Getting data from snapshot $data");
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
    return brewsCollection.doc("one").snapshots().map((_userDataFromSnapshot));
  }
}
