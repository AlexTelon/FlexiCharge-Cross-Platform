import 'package:flexicharge/theme.dart';
import 'package:flutter/material.dart';

class CircularLoadingBar extends StatelessWidget {
  const CircularLoadingBar({Key? key, required this.loadingPercentage})
      : super(key: key);

  final double loadingPercentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.20,
          height: MediaQuery.of(context).size.height * 0.40,
          child: CircularProgressIndicator(
            strokeWidth: 10,
            value: loadingPercentage,
            color: FlexiChargeTheme.midGrey,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ),
        FittedBox(
          fit: BoxFit.cover,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                width: 25,
                height: 25,
                image: AssetImage('assets/images/lightningIcon.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text((loadingPercentage * 100).toInt().toString(),
                      style: Theme.of(context).textTheme.bodyText1),
                  Text("%", style: Theme.of(context).textTheme.bodyText1)
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
