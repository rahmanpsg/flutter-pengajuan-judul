import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengajual_judul/app/themes/app_colors.dart';
import 'package:pengajual_judul/app/themes/app_text.dart';
import 'package:pengajual_judul/enums/alert_dialog_type.dart';
import 'package:stacked_services/stacked_services.dart';

class AlertDialogData {
  final AlertDialogType type;

  AlertDialogData({
    required this.type,
  });
}

class AlertDialogView extends StatelessWidget {
  final DialogRequest<AlertDialogData> request;
  final Function(DialogResponse) completer;

  const AlertDialogView({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              request.data!.type.svg,
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 8),
            Text(
              request.title ?? '',
              style: boldTextStyle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              request.description ?? '',
              style: regularTextStyle.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () => completer(DialogResponse()),
              style: ElevatedButton.styleFrom(
                backgroundColor: dangerColor,
              ),
              child: Text(request.mainButtonTitle ?? 'Tutup'),
            )
          ],
        ),
      ),
    );
  }
}
