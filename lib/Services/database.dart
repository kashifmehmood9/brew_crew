import 'package:brew_crew/Models/User.dart';
import 'package:brew_crew/Screens/Home/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //reference to collection
  final CollectionReference brewsCollection =
      FirebaseFirestore.instance.collection('brews');

  late String userID;

  DatabaseService({required this.userID});
  Future updateUserData(String sugars, String name, String strength) async {
    print("Updating records for ... $userID");
    await brewsCollection
        .doc(userID)
        .update({'sugars': sugars, 'name': name, 'strength': strength});
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
    print("Getting data from snapshot for user $userID");
    print(data);
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
    // print("Document ${brewsCollection.get()}");
    // var querySnapshot = brewsCollection.get();
    // querySnapshot.then((value) {
    //   print("Document ${value.docs.first}");
    // });

    // print("Snapshots ${brewsCollection.doc().snapshots()}");

    return brewsCollection.doc(userID).snapshots().map((_userDataFromSnapshot));
  }
}
