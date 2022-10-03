import 'package:intl/intl.dart';
import 'package:pengajual_judul/app/app.logger.dart';
import 'package:pengajual_judul/app/core/custom_base_view_model.dart';

class HomeViewModel extends CustomBaseViewModel {
  final log = getLogger("HomeViewModel");

  String get hari => DateFormat('EEEE').format(DateTime.now());
  String get tanggal => DateFormat('dd MMMM yyyy').format(DateTime.now());

  Future<void> init() async {}
}
