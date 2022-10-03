import 'package:flutter/material.dart';
import 'package:pengajual_judul/app/themes/app_colors.dart';
import 'package:pengajual_judul/app/themes/app_text.dart';
import 'package:pengajual_judul/ui/widgets/custom_chip.dart';
import 'package:pengajual_judul/ui/widgets/custom_circle_nickname.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';

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
                  // const SizedBox(height: 8),
                  // Center(
                  //   child: Text(
                  //     'Anda belum memiliki histori pengajuan judul',
                  //     style: regularTextStyle.copyWith(
                  //         color: fontDescriptionGreyColor),
                  //   ),
                  // )
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 10,
                            child: CircleAvatar(
                              backgroundColor: mainColor,
                              radius: 8,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 3.5,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            child: Center(
                              child: VerticalDivider(
                                color: mainColor,
                                width: 19.5,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Ink(
                          decoration: BoxDecoration(
                            color: greenColor.withOpacity(.2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Penerapan Kriptografi pada Data Diri dengan QR Code Menggunakan Algoritma IDEA Berbasis Android',
                                style: regularTextStyle.copyWith(
                                  color: fontGreenColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '1/1/2022',
                                style: regularTextStyle.copyWith(
                                  color: fontGreenColor.withOpacity(.6),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  CustomChip(
                                    text: 'Diterima',
                                    color: fontGreenColor,
                                    maxWidth: 300,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 10,
                            child: CircleAvatar(
                              backgroundColor: mainColor,
                              radius: 8,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 3.5,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            child: Center(
                              child: VerticalDivider(
                                color: mainColor,
                                width: 19.5,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Ink(
                          decoration: BoxDecoration(
                            color: yellowColor.withOpacity(.5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Penerapan Kriptografi pada Data Diri dengan QR Code Menggunakan Algoritma IDEA Berbasis Android',
                                style: regularTextStyle.copyWith(
                                    color: fontYellowColor),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '1/1/2022',
                                style: regularTextStyle.copyWith(
                                  color: fontYellowColor.withOpacity(.6),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  CustomChip(
                                    text: 'Menunggu Konfirmasi',
                                    color: fontYellowColor,
                                    maxWidth: 300,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 10,
                            child: CircleAvatar(
                              backgroundColor: mainColor,
                              radius: 8,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 3.5,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            child: Center(
                              child: VerticalDivider(
                                color: mainColor,
                                width: 19.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Ink(
                          decoration: BoxDecoration(
                            color: dangerColor.withOpacity(.3),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Penerapan Kriptografi pada Data Diri dengan QR Code Menggunakan Algoritma IDEA Berbasis Android',
                                style: regularTextStyle.copyWith(
                                  color: fontDangerColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '1/1/2022',
                                style: regularTextStyle.copyWith(
                                  color: fontDangerColor.withOpacity(.6),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Perjelas BAB I',
                                style: boldTextStyle.copyWith(
                                  color: fontDangerColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  CustomChip(
                                    text: 'Ditolak',
                                    color: fontDangerColor,
                                    maxWidth: 300,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
