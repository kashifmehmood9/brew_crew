import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class BrewStrengthDatabase {
  CollectionReference get brewStrengthCollection =>
      FirebaseFirestore.instance.collection('brew-strength-list');

  Future<BrewStrength> get sugars async {
    return await brewStrengthCollection
        .doc("brew-strength")
        .get()
        .then((value) {
      dynamic data = value.data();
      List list = data["strength"];
      return BrewStrength(list: list.map((e) => e.toString()).toList());
    });
  }
}

class BrewStrength {
  List<String> list;

  BrewStrength({required this.list});
}
