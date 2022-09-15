import 'package:flexicharge/models/charger.dart';
import 'package:flutter/material.dart';
import 'plug.dart';

class Plugs extends StatelessWidget {
  const Plugs({
    required this.onTap,
    required this.selectedChargerId,
    required this.chargers,
    Key? key,
  }) : super(key: key);
  final List<Charger> chargers;
  final int selectedChargerId;
  final Function(Charger)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: chargers.length == 0 ? 0 : 70,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: chargers
            .map(
              (charger) => Plug(
                onTap: () => onTap != null ? onTap!(charger) : null,
                isSelected: charger.id == selectedChargerId,
                charger: charger,
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