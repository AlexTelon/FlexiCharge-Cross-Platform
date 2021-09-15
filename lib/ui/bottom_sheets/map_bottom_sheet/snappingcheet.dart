import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/ui/bottom_sheets/map_bottom_sheet/snappingcheet_viewmodel.dart';
import 'package:flexicharge/ui/screens/home_page/home_viewmodel.dart';
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
      builder: (context, model, child) => Container(
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
        child: Container(
            height: 1000,
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
                ChargerLocations(),
                SizedBox(
                  height: 10,
                ),
                //  Plugs(
                //    chargers: model.chargers,
                //  ),
                Align(
                  alignment: Alignment.center,
                  child: ChargerCodeInput(
                    onChanged: (input) => model.chargerCode = input,
                    validator: (input) {
                      return '';
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () => model.getChargers(),
                  child: Text('connect'),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
      ),
      viewModelBuilder: () => CustomSnappingSheetViewModel(),
    );
  }
}
