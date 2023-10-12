import 'package:flexicharge/theme.dart';
import 'package:flexicharge/ui/sheets/top_sheet/top_sheet_view_model.dart';
import 'package:flexicharge/ui/widgets/charging_in_progress.dart';
import 'package:flexicharge/ui/widgets/charging_summary.dart';
import 'package:flexicharge/ui/widgets/stop_chargning_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/chargin_started.dart';

/// It's a StatelessWidget that shows a TopSheet with different content
/// depending on the chargingState
class TopSheetView extends StatelessWidget {
  const TopSheetView({
    required this.complete,
    Key? key,
  }) : super(key: key);
  final Function() complete;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TopSheetViewModel>.reactive(
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => TopSheetViewModel(),
      builder: (context, model, child) => AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * model.topSheetSize,
        decoration: BoxDecoration(
          color: FlexiChargeTheme.midGrey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height * 0.10,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  model.topSheetText,
                  style: const TextStyle(
                      color: FlexiChargeTheme.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: "ITCAvantGardeStd",
                      fontStyle: FontStyle.normal,
                      fontSize: 17.0),
                ),
              ),
            ),
            //This Widget is commented out temporarily because it shows
            //instead of the Widget below which shows the charging percent etc
            if (model.chargingState == 1)
              Container(
                  // Charging Started
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Builder(
                    builder: (BuildContext context) {
                      model.changeChargingState(false);
                      return ChargingStarted();
                    },
                  )),
            if (model.chargingState == 2 || model.chargingState == 3)
              Container(
                height: MediaQuery.of(context).size.height * 0.09,
                // Charging In Progress & Fully Charged
                child: ChargingInProgress(
                  batteryPercent: model.currentChargePercentage,
                  chargingAdress: model.chargingAdress,
                  timeUntilFullyCharged:
                      "1hr 21min until full", // this is hardcoded because we don't get it from backend yet
                  kilowattHours: model.kilowattHours,
                ),
              ),
            if (model.topSheetState == 2 &&
                (model.chargingState == 2 || model.chargingState == 3))
              Expanded(
                child: Container(
                  // Stop charging button
                  height: MediaQuery.of(context).size.height * 0.225,
                  child: Align(
                    alignment: Alignment.center,
                    child: StopChargingButton(
                        onPressed: () => model.changeChargingState(true),
                        buttonText: model.stopChargingButtonText),
                  ),
                ),
              ),
            if ((model.chargingState == 2 || model.chargingState == 3) &&
                model.topSheetState != 2)
              // Push down button
              Container(
                height: MediaQuery.of(context).size.height * 0.075,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: TextButton(
                    child: Column(
                      children: [
                        Text(model.expandButtonText,
                            style: TextStyle(color: Colors.white)),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    onPressed: () {
                      model.changeTopSheetState(2);
                    },
                  ),
                ),
              ),
            if (model.chargingState == 4 && model.topSheetState == 3)
              Expanded(
                child: ChargingSummary(
                  time: model.getChargingStopTime(
                      model.localData.transactionSession.endTimeStamp),
                  chargingDuration: model.getDuration(
                      model.localData.transactionSession.startTimestamp,
                      model.localData.transactionSession.endTimeStamp),
                  energyUsed:
                      "${model.transactionSession.kwhTransferred.toStringAsFixed(2)}kWh @ ${model.transactionSession.pricePerKwh.toStringAsFixed(2)}kr",
                  totalCost:
                      "${model.transactionSession.price.toStringAsFixed(2)}kr",
                  stopCharging: complete,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
