// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';

import '../ui/shared/judul_bottom_sheet/judul_bottom_sheet_view.dart';

enum BottomsheetType {
  judulBottomSheetView,
}

void setupBottomsheetUi() {
  var bottomsheetService = locator<BottomSheetService>();

  final builders = {
    BottomsheetType.judulBottomSheetView: (context, SheetRequest request,
            void Function(SheetResponse) completer) =>
        JudulBottomSheetView(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
