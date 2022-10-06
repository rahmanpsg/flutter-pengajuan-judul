import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pengajual_judul/app/app.bottomsheets.dart';
import 'package:pengajual_judul/app/app.logger.dart';
import 'package:pengajual_judul/models/judul_model.dart';
import 'package:pengajual_judul/models/mahasiswa_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../main.dart';
import '../../../services/auth_service.dart';
import '../../../services/judul_service.dart';

class HomeViewModel extends ReactiveViewModel {
  final log = getLogger("HomeViewModel");

  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _authService = locator<AuthService>();
  final _judulService = locator<JudulService>();

  MahasiswaModel? get mahasiswa => _authService.mahasiswa;
  List<JudulModel> get judul => _judulService.list;

  JudulModel? get judulDiterima => _judulService.judulDiterima;

  String get hari => DateFormat('EEEE').format(DateTime.now());
  String get tanggal => DateFormat('dd MMMM yyyy').format(DateTime.now());

  final key = GlobalKey();

  Future<void> init() async {
    _judulService.syncData();
  }

  void openJudulBottomSheet() async {
    await _bottomSheetService.showCustomSheet(
      variant: BottomsheetType.judulBottomSheetView,
    );
  }

  void onDownload() async {
    await _navigationService.navigateToPdfPreviewView();
  }

  void onLogout() async {
    final response = await _dialogService.showConfirmationDialog(
      title: 'Informasi',
      description: 'Apakah anda yakin ingin keluar?',
      dialogPlatform: DialogPlatform.Material,
    );

    if (response?.confirmed != true) return;

    await _authService.logout();
    await resetLocator();

    _navigationService.clearStackAndShow(Routes.signInView);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_authService, _judulService];
}
