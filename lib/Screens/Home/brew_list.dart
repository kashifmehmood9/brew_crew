import 'package:brew_crew/Screens/Home/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/Screens/Home/brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context);

    return ListView.builder(
        itemCount: brews?.length,
        itemBuilder: (context, index) {
          Brew? brew = brews?[index];
          return BrewTile(brew: brews![index]);
        });
  }
}
