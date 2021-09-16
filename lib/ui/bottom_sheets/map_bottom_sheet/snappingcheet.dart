import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/ui/bottom_sheets/map_bottom_sheet/snappingcheet_viewmodel.dart';
import 'package:flexicharge/ui/screens/home_page/home_viewmodel.dart';
import 'package:flexicharge/ui/widgets/charger_code_input.dart';
import 'package:flexicharge/ui/widgets/charging_station.dart';
import 'package:flexicharge/ui/widgets/invoice_button.dart';
import 'package:flexicharge/ui/widgets/swish_button.dart';
import 'package:flexicharge/ui/widgets/plugs.dart';
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
      builder: (context, model, child) => Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Color(0xff333333),
          borderRadius: BorderRadius.circular(15),
        ),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChargingStation(
                  onTap: () => print("Charging Button Works"),
                  adress: 'A6 Jönköping',
                  currentLocation: 'Barnarpsgatan 68',
                ),
                Plugs(
                  onTap: (id) => model.selectedChargerId = id,
                  chargers: model.chargers,
                  selectedChargerId: model.selectedChargerId,
                ),
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
                Text("Charger Identifier",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      color: Color(0xffffffff),
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      letterSpacing: -0.408,
                    )),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: ChargerCodeInput(
                    onChanged: (input) => model.chargerCode = input,
                    validator: (input) {
                      if( input == null || input.length != 6) throw ErrorDescription( "Invalid charger ID" );
                      return 'Invalid charger ID';
                    },
                  ),
                ),

                SizedBox(height: 10),
                // ignore: deprecated_member_use
                InkWell(
                  onTap: () => model.getChargers(),
                  child: Container(
                    width: 300,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff78bd76)),
                    child: Text("Begin Charging",
                        style: TextStyle(
                          fontFamily: 'ITCAvantGardePro',
                          color: Color(0xffffffff),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.3839999999999999,
                        )),
                  ),
                ),
                SizedBox(
                  height: 30,
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
