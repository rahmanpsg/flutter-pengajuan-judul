import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_text.dart';

class HomeTopBar extends StatelessWidget {
  final String hari;
  final String tanggal;
  final VoidCallback onLogout;

  const HomeTopBar({
    Key? key,
    required this.hari,
    required this.tanggal,
    required this.onLogout,
  }) : super(key: key);

  get secondaryColor => null;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hari,
              style: mediumTextStyle.copyWith(fontSize: 18),
            ),
            Text(
              tanggal,
              style: mediumTextStyle.copyWith(
                color: fontDescriptionGreyColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: onLogout,
          icon: Icon(
            UniconsLine.sign_out_alt,
            color: secondaryColor,
          ),
        )
      ],
    );
  }
}
