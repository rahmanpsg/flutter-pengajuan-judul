import 'package:flutter/material.dart';
import 'package:pengajual_judul/models/judul_model.dart';
import 'package:pengajual_judul/models/mahasiswa_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unicons/unicons.dart';

import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_text.dart';
import '../../../widgets/custom_circle_nickname.dart';

class HomeCardHeader extends StatelessWidget {
  final MahasiswaModel? mahasiswa;
  final JudulModel? judul;
  final VoidCallback? onDownload;

  const HomeCardHeader({
    super.key,
    required this.mahasiswa,
    this.judul,
    this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    if (mahasiswa == null) {
      return Shimmer.fromColors(
        baseColor: mainColor,
        highlightColor: secondaryColor,
        child: Container(
          height: 80,
          decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 80,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: secondaryColor,
          gradient: LinearGradient(
            colors: [
              secondaryColor,
              mainColor,
              secondaryColor.withAlpha(220),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 22,
              child: CustomCircleNickname(name: mahasiswa?.nama ?? ''),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mahasiswa?.nama ?? '',
                    style: boldTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    mahasiswa?.nim ?? '',
                    style: boldTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  if (judul != null) ...[
                    const SizedBox(height: 8),
                    const Divider(
                      color: Colors.white,
                    ),
                    Text(
                      judul?.judul ?? '',
                      style: regularTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 45,
                      child: OutlinedButton.icon(
                        onPressed: onDownload,
                        icon: const Icon(UniconsLine.file_download_alt),
                        label: const Text(
                            'Unduh Formulir Pernyataan Calon Dosen Pembimbing'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          disabledForegroundColor: Colors.white54,
                          side: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
