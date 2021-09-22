import 'package:flutter/material.dart';

class ChargingSummary extends StatelessWidget {
  const ChargingSummary({
    Key? key,
    required this.chargingDuration,
    required this.energyUsed,
    required this.totalCost,
  }) : super(key: key);

  final String chargingDuration;
  final String energyUsed;
  final String totalCost;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Charging stopped at 16:41",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              )),
          Expanded(
              flex: 1,
              child: Row(
                // Displaying charging duration.
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Duration ",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    chargingDuration,
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              )),
          Expanded(
            flex: 1,
            child: Row(
              // Displaying energy used during charging.
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Energy used ",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  energyUsed,
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            ),
          ),
          Expanded(
            // Displaying Total cost
            flex: 2,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width * 0.50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  border: Border.all(color: const Color(0xffe5e5e5), width: 1),
                  color: const Color(0xffffffff)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Total Cost",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    totalCost,
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Your receipt for this charging session and others can be found on the Invoices Page.",
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () => {print("TEST")},
              child: Container(
                  child: Image(
                width: 50,
                height: 50,
                image: AssetImage('assets/images/white_x_icon.png'),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
