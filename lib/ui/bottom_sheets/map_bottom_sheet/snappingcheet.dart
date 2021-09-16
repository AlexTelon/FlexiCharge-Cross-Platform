import 'package:flexicharge/ui/bottom_sheets/map_bottom_sheet/snappingcheet_viewmodel.dart';
import 'package:flexicharge/ui/widgets/charger_code_input.dart';
import 'package:flexicharge/ui/widgets/charger_locations.dart';
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
      builder: (context, model, child) => SizedBox(
        height: 1000,
        child: Container(
          height: 1000,
          padding: EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 25
          ),
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
                  Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () {
                        completer(SheetResponse(data: null));
                      },
                      icon: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white,),
                    ),
                  ),
                  ChargerLocations(
                    onTap: (chargingPointId) => {
                      completer(SheetResponse(data: null))  //test
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                   Plugs(
                     chargers: model.chargers, 
                     onTap: (id ) => model.selectedChargerId = id, 
                     selectedChargerId: model.selectedChargerId,
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
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
      ), viewModelBuilder: () => CustomSnappingSheetViewModel(),
      ); 
  }
}
