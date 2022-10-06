import 'package:flutter/material.dart';
import 'package:pengajual_judul/app/themes/app_colors.dart';
import 'package:pengajual_judul/models/file_data_model.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/themes/app_text.dart';
import 'custom_chip.dart';

class CustomCardTimeline extends StatelessWidget {
  final String title;
  final String subtitle;
  final FileDataModel? fileData;
  final String? description;
  final String status;
  final Color color;
  final Color textColor;
  final bool showDividerLine;

  const CustomCardTimeline({
    super.key,
    required this.title,
    required this.subtitle,
    this.fileData,
    this.description,
    required this.status,
    required this.color,
    required this.textColor,
    this.showDividerLine = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(width: 32),
            Flexible(
              child: Ink(
                decoration: BoxDecoration(
                  color: color.withOpacity(.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
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
                              title,
                              style: boldTextStyle.copyWith(
                                fontSize: 16,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subtitle,
                              style: regularTextStyle.copyWith(
                                color: textColor.withOpacity(.6),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (fileData?.url != null)
                          CircleAvatar(
                            backgroundColor: color.withOpacity(.8),
                            child: IconButton(
                              onPressed: () async {
                                try {
                                  await launchUrl(Uri.parse(fileData!.url!),
                                      mode: LaunchMode.externalApplication);
                                } catch (e) {
                                  print(e);
                                }
                              },
                              icon: const Icon(
                                UniconsLine.file_download,
                                color: Colors.white,
                              ),
                            ),
                          )
                      ],
                    ),

                    if (description != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        description ?? '',
                        style: mediumTextStyle.copyWith(
                          color: textColor,
                        ),
                      )
                    ],
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        CustomChip(
                          text: status,
                          color: textColor,
                          maxWidth: 300,
                        ),
                      ],
                    ),
                    // ...[
                    //   const SizedBox(height: 8),
                    //   ListTile(
                    //     onTap: () {},
                    //     dense: true,
                    //     minLeadingWidth: 0,
                    //     shape: RoundedRectangleBorder(
                    //       side: BorderSide(color: textColor.withOpacity(.6)),
                    //       borderRadius: BorderRadius.circular(6),
                    //     ),
                    //     leading: SvgPicture.asset(
                    //       'assets/svg/doc.svg',
                    //       width: 30,
                    //     ),
                    //     title: Text(
                    //       fileData?.name ??
                    //           'asasajsajs asdasdad  sdd dsds .pdf',
                    //       style: regularTextStyle.copyWith(
                    //         color: textColor,
                    //       ),
                    //     ),
                    //     subtitle: Text(
                    //       fileData?.size ?? '343.2 KB',
                    //       style: regularTextStyle.copyWith(
                    //         color: textColor.withOpacity(.6),
                    //       ),
                    //     ),
                    //   ),
                    // ],
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(
          width: 20,
          height: 130,
          child: OverflowBox(
            minHeight: 200,
            maxHeight: 500,
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const CircleAvatar(
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
                Flexible(
                  child: Center(
                    child: VerticalDivider(
                      color: showDividerLine ? mainColor : backgroundColor,
                      width: 19.5,
                      thickness: showDividerLine ? 0 : 2,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
