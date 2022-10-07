import 'package:flexicharge/ui/sheets/map_bottom_sheet/nearest_chargers.dart';
import 'package:flexicharge/ui/sheets/map_bottom_sheet/select_charger.dart';
import 'package:flexicharge/ui/sheets/map_bottom_sheet/snappingcheet_viewmodel.dart';
import 'package:flexicharge/ui/widgets/charger_code_input.dart';
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
      onModelReady: (model) => model.init(request),
      builder: (context, model, child) => AnimatedContainer(
        curve: Curves.easeInOut,
        duration: Duration(
          seconds: model.onlyPin ? 1 : 3,
        ),
        height: model.onlyPin ? 250 : 1500,
        decoration: BoxDecoration(
          //color: Color(0xff333333),
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (model.onlyPin)
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => model.onlyPin = false,
                          icon: Icon(
                            Icons.keyboard_arrow_up_sharp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Chargers Near Me',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Color(0xffffffff),
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            letterSpacing: -0.408,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (!model.onlyPin)
                  model.isFirstView
                      ? NearestChargers(completer: completer)
                      : BeginCharging(),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Align(
                    alignment: Alignment.center,
                    child: ChargerCodeInput(
                      key:
                          ValueKey<String>(model.selectedCharger.id.toString()),
                      controller:
                          TextEditingController(text: model.chargerCode),
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
                ),
                SizedBox(height: 10),
                WideButton(
                  key: ValueKey<String>(model.selectedCharger.id.toString()),
                  color: model.wideButtonColor,
                  text: model.wideButtonText,
                  onTap: () async {
                    await model.connect(model.selectedCharger.id, context);
                    model.localData.chargingCharger = model.selectedCharger.id;
                    model.localData.isButtonActive = false;
                    completer(SheetResponse(data: true));
                    print(model.selectedCharger.id);
                  },
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
