import 'package:flexicharge/models/charger.dart';
import 'package:flutter/material.dart';
import 'package:flexicharge/ui/widgets/plug.dart';

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
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: 100.0,
      width: 400,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: widget.chargers
            .map(
              (charger) => Container(
                width: 160.0,
                child: Row(
                  children: [
                    Plug(),
                  ],
                ),
              ),
            )
            .toList(),
      ),
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