import 'package:flexicharge/ui/screens/home_page/home_viewmodel.dart';
import 'package:flexicharge/ui/widgets/charger_code_input.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SnappingSheet extends ViewModelWidget<HomeViewModel> {
  const SnappingSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    var snappingSheetController = model.snappingSheetController;
    var bottomSnapp = MediaQuery.of(context).viewPadding.bottom + 95;
    var topSnapp = MediaQuery.of(context).size.height - 230;
    return SizedBox.expand(
      // child: InkWell(
      //     child: Container(
      //         child: ChargerCodeInput(
      //   onChanged: () => null,

      //   validator: ,
      // ),),),
    );
  }
}
