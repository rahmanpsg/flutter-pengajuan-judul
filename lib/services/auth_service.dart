import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pengajual_judul/app/app.logger.dart';
import 'package:pengajual_judul/models/mahasiswa_model.dart';
import 'package:pengajual_judul/services/secure_storage_service.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../models/api_response_model.dart';

class AuthService with ReactiveServiceMixin {
  AuthService() {
    listenToReactiveValues([_mahasiswa]);
  }
  final log = getLogger('AuthService');

  final _firebaseFirestore = FirebaseFirestore.instance;
  final _secureStorage = locator<SecureStorageService>();

  final ReactiveValue<MahasiswaModel?> _mahasiswa =
      ReactiveValue<MahasiswaModel?>(null);

  Future<void> syncData() async {
    final user = await _secureStorage.read(key: 'user');

    _mahasiswa.value =
        user != null ? MahasiswaModel.fromJson(jsonDecode(user)) : null;

    log.d("mahasiswa: ${_mahasiswa.value}");
  }

  Future<ApiResponseModel<MahasiswaModel>> login({
    required String nim,
    required String password,
  }) async {
    try {
      log.d("nim: $nim");
      final response = await _firebaseFirestore
          .collection('mahasiswas')
          .where('nim', isEqualTo: nim)
          .limit(1)
          .get();

      log.d("response: ${response.docs}");

      if (response.docs.isEmpty) {
        return ApiResponseModel.error(message: 'NIM tidak terdaftar');
      }

      final mahasiswa = MahasiswaModel.fromJson(response.docs.first.data());

      if (mahasiswa.password != password) {
        return ApiResponseModel.error(message: 'Password salah');
      }

      _mahasiswa.value = mahasiswa;

      _secureStorage.write(key: 'user', value: jsonEncode(mahasiswa.toJson()));

      return ApiResponseModel.success(data: mahasiswa);
    } on FirebaseException catch (e) {
      log.e(e);

      return ApiResponseModel.error(
          message: e.message ?? 'Terjadi masalah yang tidak diketahui');
    } on Exception catch (e) {
      log.e(e);

      return ApiResponseModel.error(
          message: 'Terjadi masalah yang tidak diketahui');
    }
  }

  Future logout() async {
    _mahasiswa.value = null;
    _secureStorage.clear();
  }

  bool get isLoggedIn => mahasiswa != null;
  MahasiswaModel? get mahasiswa => _mahasiswa.value;
}
