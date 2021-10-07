import 'package:flexicharge/enums/bottom_sheet_type.dart';
import 'package:flexicharge/ui/bottom_sheets/map_bottom_sheet/snappingcheet.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    SheetType.mapBottomSheet: (context, sheetRequest, completer) =>
        CustomSnappingSheet(request: sheetRequest, completer: completer),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}
