import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pengajual_judul/app/app.dialog.dart';
import 'package:pengajual_judul/app/core/custom_base_view_model.dart';
import 'package:pengajual_judul/enums/alert_dialog_type.dart';
import 'package:pengajual_judul/models/judul_model.dart';
import 'package:pengajual_judul/ui/shared/alert_dialog/alert_dialog_view.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/api/firebase_storage_api.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../models/file_data_model.dart';
import '../../../services/auth_service.dart';
import '../../../services/judul_service.dart';

class JudulBottomSheetViewModel extends CustomBaseViewModel {
  final log = getLogger("JudulBottomSheetViewModel");

  final _firebaseStorage = FirebaseStorageApi();
  final _judulService = locator<JudulService>();

  late final Function(SheetResponse) completer;

  final formKey = GlobalKey<FormState>();

  final JudulModel judul = JudulModel(
    mahasiswaId: locator<AuthService>().mahasiswa?.id,
  );
  FileDataModel? fileData;

  Future<void> init(Function(SheetResponse) completer) async {
    this.completer = completer;
  }

  void openFilePicker(TextEditingController controller) async {
    final response = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['doc', 'docx', 'pdf'],
    );

    log.d("response: $response");

    if (response == null) return;

    final file = response.files.first;

    fileData = FileDataModel(
      name: file.name,
      bytes: file.size,
      path: file.path,
    );

    log.d(fileData);

    controller.text = "${fileData?.name} (${fileData?.size})";
  }

  void onSubmit() async {
    if (formKey.currentState?.validate() != true) return;

    setBusy(true);

    try {
      final response = await _judulService.deteksi(judul);

      if (response.any((x) => x.persentase > 70)) {
        setBusy(false);
        await dialogService.showCustomDialog(
          variant: DialogType.alertDialogView,
          data: AlertDialogData(type: AlertDialogType.warning),
          title: 'Gagal mengirim judul',
          description:
              'Judul yang anda ajukan memiliki kemiripan ${response.first.persentase.toStringAsFixed(2)}% dengan judul yang sudah ada',
        );
        return;
      }

      if (fileData == null) return;

      final uploadTask = await _firebaseStorage.uploadFile(
        "juduls/${judul.id}_${fileData?.name}",
        fileData!.path!,
      );

      if (uploadTask == null) return;

      log.d("Uploading file...");

      final ts = await uploadTask;

      final url = await ts.ref.getDownloadURL();

      log.i(url);

      fileData?.url = url;

      judul.fileData = fileData;

      await _judulService.save(judul);

      setBusy(false);

      completer(
        SheetResponse(
          confirmed: true,
          data: judul,
        ),
      );

      await dialogService.showCustomDialog(
        variant: DialogType.alertDialogView,
        data: AlertDialogData(type: AlertDialogType.success),
        title: 'Informasi',
        description:
            'Judul berhasil diajukan, silahkan tunggu konfirmasi dari admin.',
      );
    } catch (e) {
      log.d(e);
      dialogService.showCustomDialog(
        variant: DialogType.alertDialogView,
        data: AlertDialogData(type: AlertDialogType.warning),
        title: 'Informasi',
        description: 'Terjadi masalah, silahkan coba kembali!',
      );
    }
  }
}
