import 'package:flexicharge/ui/bottom_sheets/top_sheet/top_sheet_view_model.dart';
import 'package:flexicharge/ui/widgets/chargin_started.dart';
import 'package:flexicharge/ui/widgets/charging_in_progress.dart';
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => model.testTopSheet(),
                        child: Text("Test"),
                      ),
                      Text(model.topSheetText,
                          style: const TextStyle(
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                              fontFamily: "ITCAvantGardeStd",
                              fontStyle: FontStyle.normal,
                              fontSize: 20.0),
                          textAlign: TextAlign.center),
                    ],
                  ),
                  if (model.chargingState == 1) ChargingStarted(),
                  if (model.chargingState == 2 || model.chargingState == 3)
                    ChargingInProgress(
                      batteryProcent: model.batteryProcent,
                      chargingAdress: model.chargingAdress,
                      timeUntilFullyCharged: model.timeUntilFullyCharged,
                      kilowattHours: model.kilowattHours,
                    ),
                  if (model.chargingState != 1) Spacer(),
                  Expanded(
                    child: TextButton(
                      child: Text('Press to stop charging'),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        textStyle: const TextStyle(
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Lato",
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                      ),
                      onPressed: () {
                        model.changeTopSheetSize();
                      },
                    ),
                  ),
                ],
              ),
            ));
  }
}
