import 'package:flexicharge/ui/bottom_sheets/top_sheet/top_sheet_view_model.dart';
import 'package:flexicharge/ui/widgets/chargin_started.dart';
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
              height: MediaQuery.of(context).size.height * 0.3,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color(0xff333333),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(model.getTitleText(),
                        style: const TextStyle(
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            fontFamily: "ITCAvantGardeStd",
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0),
                        textAlign: TextAlign.center),
                  ),
                  Expanded(
                    flex: 2,
                    child: ChargingStarted(
                      imageOne: SvgPicture.asset(
                          '/assets/svg_images/logoIconColor.svg'),
                      imageTwo: SvgPicture.asset(
                          '/assets/svg_images/logoIconColor.svg'),
                    ),
                  ),
                  if (model.chargeInProgress)
                    Expanded(
                        child: TextButton(
                      child: Text('"Pull down to stop charging"'),
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Lato",
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                      ),
                      onPressed: () {
                        print("stop charging");
                      },
                    ))
                ],
              ),
            ));
  }
}
