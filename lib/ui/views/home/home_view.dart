import 'package:flutter/material.dart';
import 'package:pengajual_judul/app/themes/app_colors.dart';
import 'package:pengajual_judul/app/themes/app_text.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';

import '../../widgets/custom_card_timeline.dart';
import './home_view_model.dart';
import 'widgets/home_card_header.dart';
import 'widgets/home_top_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (HomeViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          floatingActionButton: model.judulDiterima != null
              ? null
              : FloatingActionButton(
                  onPressed: model.openJudulBottomSheet,
                  child: const Icon(UniconsLine.file_plus),
                ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeTopBar(
                    hari: model.hari,
                    tanggal: model.tanggal,
                    onLogout: model.onLogout,
                  ),
                  const SizedBox(height: 16),
                  HomeCardHeader(
                    mahasiswa: model.mahasiswa,
                    judul: model.judulDiterima,
                    onDownload: model.onDownload,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Histori',
                    style: mediumTextStyle.copyWith(fontSize: 22),
                  ),
                  const Divider(),
                  if (model.judul.isEmpty) ...[
                    const SizedBox(height: 32),
                    Center(
                      child: Text(
                        'Tidak ada data histori pengajuan judul',
                        style: regularTextStyle.copyWith(
                            color: fontDescriptionGreyColor),
                      ),
                    ),
                  ] else
                    Flexible(
                      child: Card(
                        color: backgroundColor,
                        elevation: 0,
                        margin: const EdgeInsets.all(0),
                        child: ListView.separated(
                          itemCount: model.judul.length,
                          itemBuilder: (context, index) {
                            final judul = model.judul[index];

                            return CustomCardTimeline(
                              title: judul.judul ?? '',
                              subtitle: judul.tanggalUploadFormat,
                              fileData: judul.fileData,
                              description: judul.koreksi,
                              status: judul.statusString,
                              color: judul.statusColor,
                              textColor: judul.statusFontColor,
                              showDividerLine: model.judul.length - 1 != index,
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 16,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
