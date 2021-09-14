import 'package:flexicharge/models/charger.dart';
import 'package:flutter/material.dart';
import 'plug.dart';

class Plugs extends StatefulWidget {
  const Plugs({required this.chargers, Key? key}) : super(key: key);
  final List<Charger> chargers;

  @override
  _PlugsState createState() => _PlugsState();
}

class _PlugsState extends State<Plugs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Plug(),
    );
  }
}

/*
chargers
            .map(
              (charger) => Container(
                color: Colors.blue,
                width: 160.0,
                height: 200,
                child: Row(
                  children: [Text('available'), Text(charger.id)],
                ),
              ),
            )
            .toList(),

*/ 