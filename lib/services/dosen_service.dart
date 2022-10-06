import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pengajual_judul/models/dosen_model.dart';

import '../app/app.logger.dart';

class DosenService {
  final log = getLogger("DosenService");

  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<DosenModel> get(String id) async {
    final response = await _firebaseFirestore
        .collection('dosens')
        .where('id', isEqualTo: id)
        .limit(1)
        .get();

    log.d("response: ${response.docs}");

    if (response.docs.isEmpty) {
      throw Exception("Dosen tidak ditemukan");
    }

    return DosenModel.fromJson(response.docs.first.data());
  }
}
