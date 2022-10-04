import 'package:flutter/material.dart';
import 'package:pengajual_judul/app/themes/app_colors.dart';
import 'package:pengajual_judul/app/themes/app_text.dart';
import 'package:pengajual_judul/ui/widgets/custom_circle_nickname.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';

import '../../widgets/custom_card_timeline.dart';
import './home_view_model.dart';

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
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(UniconsLine.file_plus),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.hari,
                            style: mediumTextStyle.copyWith(fontSize: 18),
                          ),
                          Text(
                            model.tanggal,
                            style: mediumTextStyle.copyWith(
                              color: fontDescriptionGreyColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          UniconsLine.sign_out_alt,
                          color: secondaryColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 80,
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
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 22,
                          child: CustomCircleNickname(name: 'Abd Rahman'),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Abd. Rahman',
                              style: boldTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '214280187',
                              style: boldTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Histori',
                    style: mediumTextStyle.copyWith(fontSize: 22),
                  ),
                  const Divider(),
                  Column(
                    children: [
                      CustomCardTimeline(
                        title:
                            'Penerapan Kriptografi pada Data Diri dengan QR Code Menggunakan Algoritma IDEA Berbasis Android ',
                        subtitle: '1/1/2022',
                        description:
                            'Penerapan Kriptografi pada Data Diri dengan QR Code Menggunakan Algoritma IDEA Berbasis Android',
                        status: 'Diterima',
                        color: dangerColor,
                        textColor: fontDangerColor,
                      ),
                      const SizedBox(height: 16),
                      CustomCardTimeline(
                        title:
                            'Penerapan Kriptografi pada Data Diri dengan QR Code Menggunakan Algoritma IDEA Berbasis Android',
                        subtitle: '1/1/2022',
                        status: 'Diterima',
                        color: greenColor,
                        textColor: fontGreenColor,
                        showDividerLine: false,
                      ),
                    ],
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
