import 'package:flexicharge/ui/bottom_sheets/top_sheet/top_sheet_view_model.dart';
import 'package:flexicharge/ui/widgets/chargin_started.dart';
import 'package:flexicharge/ui/widgets/charging_in_progress.dart';
import 'package:flexicharge/ui/widgets/charging_summary.dart';
import 'package:flexicharge/ui/widgets/stop_chargning_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TopSheetView extends StatelessWidget {
  const TopSheetView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TopSheetViewModel>.reactive(
        viewModelBuilder: () => TopSheetViewModel(),
        builder: (context, model, child) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * model.topSheetSize,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color(0xff333333),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: TextButton(
                      // Todo: Change Textbutton() to Text() when finished with UI.
                      onPressed: () => model.changeChargingState(false),
                      child: Text(
                        model.topSheetText,
                        style: const TextStyle(
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            fontFamily: "ITCAvantGardeStd",
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                  if (model.chargingState == 1)
                    Expanded(
                      flex: 1,
                      child: ChargingStarted(),
                    ),
                  if (model.chargingState == 2 || model.chargingState == 3)
                    Expanded(
                      flex: 1,
                      child: ChargingInProgress(
                        batteryProcent: model.batteryProcent,
                        chargingAdress: model.chargingAdress,
                        timeUntilFullyCharged: model.timeUntilFullyCharged,
                        kilowattHours: model.kilowattHours,
                      ),
                    ),
                  if (model.topSheetState == 2 &&
                      (model.chargingState == 2 || model.chargingState == 3))
                    FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: StopChargingButton(
                            onPressed: () => model.changeChargingState(true),
                            buttonText: model.stopChargingButtonText),
                      ),
                    ),
                  if ((model.chargingState == 2 || model.chargingState == 3) &&
                      model.topSheetState != 2)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        child: Column(
                          children: [
                            Text(model.expandButtonText,
                                style: TextStyle(color: Colors.white)),
                            Image(
                                width: 30,
                                height: 30,
                                image:
                                    AssetImage('assets/images/arrow_down.png'))
                          ],
                        ),
                        onPressed: () {
                          model.changeTopSheetState(2);
                        },
                      ),
                    ),
                  if (model.chargingState == 4 && model.topSheetState == 3)
                    Expanded(
                      child: ChargingSummary(
                        chargingDuration: "1hr 41min",
                        energyUsed: "9.1kWh @ 3.00 kr kWh",
                        totalCost: "27.3kr",
                        stopCharging: () => model.changeChargingState(false),
                      ),
                    ),
                ],
              ),
            ));
  }
}
