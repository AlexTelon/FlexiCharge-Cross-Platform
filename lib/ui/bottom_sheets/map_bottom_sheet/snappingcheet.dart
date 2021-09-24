import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/ui/bottom_sheets/map_bottom_sheet/snappingcheet_viewmodel.dart';
import 'package:flexicharge/ui/widgets/charger_code_input.dart';
import 'package:flexicharge/ui/widgets/charger_locations.dart';
import 'package:flexicharge/ui/widgets/charging_station.dart';
import 'package:flexicharge/ui/widgets/invoice_button.dart';
import 'package:flexicharge/ui/widgets/plugs.dart';
import 'package:flexicharge/ui/widgets/swish_button.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CustomSnappingSheet extends StatelessWidget {
  const CustomSnappingSheet({
    required this.request,
    required this.completer,
    Key? key,
  }) : super(key: key);
  final SheetRequest request;
  final Function(SheetResponse) completer;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomSnappingSheetViewModel>.reactive(
      builder: (context, model, child) => SizedBox(
        height: 1000,
        child: Container(
          height: 1000,
          padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
          decoration: BoxDecoration(
            //color: Color(0xff333333),
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (model.selectedCharger.id == -1)
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: () {
                            completer(SheetResponse(data: null));
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ChargerLocations(
                        chargers: model.nearestLocation,
                        onTap: (chargingPointId) {
                          model.selectedCharger.id = chargingPointId;
                          model.getChargersFromNearest();
                        },
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10,
                ),
                if (model.selectedCharger.id != -1)
                  Column(
                    children: [
                      ChargingStation(
                        onTap: () => model.changWideget(),
                        adress: 'A6 Jönköping',
                        currentLocation: 'Barnarpsgatan 68',
                      ),
                      SizedBox(height: 20),
                      Plugs(
                        chargers: model.chargers,
                        onTap: (charger) => model.selectedCharger = charger,
                        selectedChargerId: model.selectedCharger.id,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Payment",
                        style: TextStyle(
                            fontFamily: 'Lato',
                            color: Color(0xffffffff),
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            letterSpacing: -0.408),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SwichButton(
                            onTap: () {
                              model.isSwishActive = true;
                              print("Swish Payment In Progress");
                            },
                            isSelected: model.isSwishActive,
                          ),
                          InvoiceButton(
                            onTap: () {
                              model.isSwishActive = false;
                              print("Swish Payment In Progress");
                            },
                            isSelected: !model.isSwishActive,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),

                Align(
                  alignment: Alignment.center,
                  child: ChargerCodeInput(
                    onChanged: (input) => model.chargerCode = input,
                    validator: (input) {
                      if (input == null || input.length != 6) {
                        if (input!.length == 0 || input.length != 6) {
                          model.showWideButton = false;
                        } else {
                          model.showWideButton = true;
                        }
                        return "Invalid charger ID";
                      } else {
                        model.chargerCode = input;
                        model.getChargerById(int.parse(input));
                        model.showWideButton = true;

                        return '';
                      }
                    },
                  ),
                ),

                SizedBox(height: 10),

                // ignore: deprecated_member_use
                WideButton(
                  color: model.wideButtonColor,
                  text: model.wideButtonText,
                  onTap: () => model.updateStatus(
                    0,
                    model.selectedCharger.id,
                    1,
                  ),
                  showWideButton: model.showWideButton,
                ),

                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => CustomSnappingSheetViewModel(),
    );
  }
}
