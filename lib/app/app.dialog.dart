// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';

import '../ui/shared/alert_dialog/alert_dialog_view.dart';

enum DialogType {
  alertDialogView,
}

void setupDialogUi() {
  var dialogService = locator<DialogService>();

  final builders = {
    DialogType.alertDialogView:
        (context, request, void Function(DialogResponse) completer) =>
            AlertDialogView(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
