import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pengajual_judul/app/app.logger.dart';
import 'package:pengajual_judul/app/core/custom_base_view_model.dart';

class HomeViewModel extends CustomBaseViewModel {
  final log = getLogger("HomeViewModel");

  String get hari => DateFormat('EEEE').format(DateTime.now());
  String get tanggal => DateFormat('dd MMMM yyyy').format(DateTime.now());

  final key = GlobalKey();

  Future<void> init() async {
    final box = key.currentContext?.findRenderObject();
    if (box == null) return;
    Offset position =
        (box as RenderBox).localToGlobal(Offset.zero); //this is global position
    double y = position.dy;

    log.d('y: $y');
  }
}
