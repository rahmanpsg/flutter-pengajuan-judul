import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pengajual_judul/app/app.logger.dart';
import 'package:pengajual_judul/models/mahasiswa_model.dart';

import '../models/api_response_model.dart';

class AuthService {
  final log = getLogger('AuthService');

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
    throw false;
    // try {
    //   await _firebaseAuth.signOut();
    // } catch (e) {
    //   log.e(e);
    // }
  }
}
