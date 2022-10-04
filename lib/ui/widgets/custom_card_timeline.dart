import 'package:flutter/material.dart';
import 'package:pengajual_judul/app/themes/app_colors.dart';

import '../../app/themes/app_text.dart';
import 'custom_chip.dart';

class CustomCardTimeline extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? description;
  final String status;
  final Color color;
  final Color textColor;
  final bool showDividerLine;

  const CustomCardTimeline({
    super.key,
    required this.title,
    required this.subtitle,
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
                    Text(
                      title,
                      style: regularTextStyle.copyWith(
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
                    if (description != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        description ?? '',
                        style: boldTextStyle.copyWith(
                          color: textColor,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        CustomChip(
                          text: status,
                          color: color,
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
