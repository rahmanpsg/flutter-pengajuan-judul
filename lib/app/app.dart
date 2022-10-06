import 'package:pengajual_judul/services/auth_service.dart';
import 'package:pengajual_judul/services/dosen_service.dart';
import 'package:pengajual_judul/services/judul_service.dart';
import 'package:pengajual_judul/services/secure_storage_service.dart';
import 'package:pengajual_judul/ui/shared/alert_dialog/alert_dialog_view.dart';
import 'package:pengajual_judul/ui/views/home/home_view.dart';
import 'package:pengajual_judul/ui/views/pdf_preview/pdf_preview_view.dart';
import 'package:pengajual_judul/ui/views/sign_in/sign_in_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../ui/shared/judul_bottom_sheet/judul_bottom_sheet_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SignInView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: PdfPreviewView),
  ],
  dialogs: [
    StackedDialog(classType: AlertDialogView),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: JudulBottomSheetView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: SecureStorageService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: JudulService),
    LazySingleton(classType: DosenService),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
