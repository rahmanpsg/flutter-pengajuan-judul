import 'package:collection/collection.dart';
import 'package:pengajual_judul/app/core/custom_base_service.dart';
import 'package:pengajual_judul/models/judul_model.dart';

import '../app/api/api.dart';
import '../app/app.locator.dart';
import '../models/hasil_deteksi_model/hasil_deteksi_model.dart';
import 'auth_service.dart';

class JudulService extends CustomBaseService<JudulModel> {
  JudulService()
      : super(
          collectionPath: 'juduls',
          orderBy: 'createdAt',
          descending: true,
          whereField: 'mahasiswaId',
          whereValue: locator<AuthService>().mahasiswa?.id,
          fromJson: JudulModel.fromJson,
        );

  final _api = Api();

  Future<List<HasilDeteksiModel>> deteksi(JudulModel judul, [int K = 3]) async {
    final response = await _api.post('proses', {
      'text': judul.judul,
      'k': K,
    });

    if (response.error) {
      throw response;
    }

    List<HasilDeteksiModel> hasils = [];

    for (var hasil in response.data) {
      hasils.add(HasilDeteksiModel.fromJson(hasil));
    }

    return hasils;
  }

  JudulModel? get judulDiterima =>
      list.firstWhereOrNull((judul) => judul.status == true);
}
