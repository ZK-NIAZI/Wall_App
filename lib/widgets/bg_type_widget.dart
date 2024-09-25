import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

BgTypeWidget(
  BuildContext context,
  VoidCallback onHomeTap,
  VoidCallback onBothTap,
) {
  Widget cancelButton = ElevatedButton(
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppColors.primaryColor),
    onPressed: onHomeTap,
    child: const Text(
      "Home",
      style: TextStyle(color: AppColors.white),
      textAlign: TextAlign.center,
    ),
  );
  Widget okButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: AppColors.primaryColor),
      onPressed: onBothTap,
      child: const Text(
        "Both",
        style: TextStyle(color: AppColors.white),
        textAlign: TextAlign.center,
      ));

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    backgroundColor: AppColors.white,
    title: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 220),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              )),
        ),
        const Text(
          "Set BackGround As",
          style: TextStyle(
            color: AppColors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    titlePadding: const EdgeInsets.all(10),
    content: const Text(
      "Select Where You want to This Images as Background",
      style: TextStyle(
          color: AppColors.black, fontWeight: FontWeight.w300, fontSize: 16),
      textAlign: TextAlign.center,
    ),
    actions: [
      Expanded(child: cancelButton),
      Expanded(child: okButton),
    ],
    actionsAlignment: MainAxisAlignment.center,
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
