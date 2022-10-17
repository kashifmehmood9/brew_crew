import 'package:brew_crew/Screens/Home/brew.dart';
import 'package:brew_crew/Screens/Home/settings_form.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatefulWidget {
  final Brew brew;
  BrewTile({required this.brew});

  @override
  State<BrewTile> createState() => _BrewTileState();
}

class _BrewTileState extends State<BrewTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          isThreeLine: true,
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[widget.brew.strength],
            backgroundImage: AssetImage("assets/coffee_icon.png"),
          ),
          title: Text(widget.brew.name),
          subtitle: Text(
              'Takes ${widget.brew.sugars} sugars \n Coffee Strength ${widget.brew.strength}'),
          onTap: () {
            _createBottomSheet(context);
          },
        ),
      ),
    );
  }
}

void _createBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SettingsForm(),
        );
      });
}
