import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class DialogWarning {
  static void show(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      headerAnimationLoop: false,
      animType: AnimType.scale,
      title: 'Fitur dalam pengembangan',
      btnOkOnPress: () {},
      btnOkColor: Colors.blue,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: true,
    ).show();
  }
}
