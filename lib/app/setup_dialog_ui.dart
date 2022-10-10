import 'package:flexicharge/enums/bottom_sheet_type.dart';
import 'package:flexicharge/ui/sheets/map_bottom_sheet/snappingcheet.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';

/// It sets up the bottom sheet service to use the custom snapping sheet
/// widget when the map bottom sheet is requested
void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    SheetType.mapBottomSheet: (context, sheetRequest, completer) =>
        CustomSnappingSheet(request: sheetRequest, completer: completer),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}
