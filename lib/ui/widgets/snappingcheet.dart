import 'package:flexicharge/ui/screens/home_page/home_viewmodel.dart';
import 'package:flexicharge/ui/widgets/charger_code_input.dart';
import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:stacked/stacked.dart';

class CustomSnappingSheet extends ViewModelWidget<HomeViewModel> {
  const CustomSnappingSheet({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    var snappingSheetController = model.snappingSheetController;
    var bottomSnapp = MediaQuery.of(context).viewPadding.bottom + 95;
    var topSnapp = MediaQuery.of(context).size.height - 230;
    return SizedBox.expand(
      child: InkWell(
        onTap: () {
          snappingSheetController.snapToPosition(
            SnappingPosition.pixels(
              positionPixels: snappingSheetController.currentSnappingPosition ==
                      SnappingPosition.pixels(
                        positionPixels: bottomSnapp,
                      )
                  ? topSnapp
                  : bottomSnapp,
              grabbingContentOffset:
                  snappingSheetController.currentSnappingPosition ==
                          SnappingPosition.pixels(positionPixels: bottomSnapp)
                      ? GrabbingContentOffset.top
                      : GrabbingContentOffset.bottom,
            ),
          );
        },
        child: SnappingSheet(
          controller: snappingSheetController,
          lockOverflowDrag: true,
          grabbingHeight: 100,
          child: child,
          snappingPositions: [
            SnappingPosition.pixels(
              positionPixels: bottomSnapp,
              grabbingContentOffset: GrabbingContentOffset.bottom,
              snappingDuration: Duration(milliseconds: 200),
              snappingCurve: Curves.linear,
            ),
            SnappingPosition.pixels(
              positionPixels: topSnapp,
              snappingDuration: Duration(milliseconds: 200),
              grabbingContentOffset: GrabbingContentOffset.top,
              snappingCurve: Curves.linear,
            )
          ],
          grabbing: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: BorderDirectional(
                bottom: BorderSide(
                    color: Theme.of(context).colorScheme.secondaryVariant),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
