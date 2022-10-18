import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class BrewStrengthDatabase {
  CollectionReference get brewStrengthCollection =>
      FirebaseFirestore.instance.collection('brew-strength-list');

  Future<CoffeeSugars> get sugars async {
    return await brewStrengthCollection
        .doc("brew-strength")
        .get()
        .then((value) {
      dynamic data = value.data();
      List list = data["strength"];
      return CoffeeSugars(list: list.map((e) => e.toString()).toList());
    });
  }
}

class CoffeeSugars {
  List<String> list;

  CoffeeSugars({required this.list});
}
