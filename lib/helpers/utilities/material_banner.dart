import 'package:creator/creator.dart';
import 'package:flutter/material.dart';

MaterialBanner banner({
  Widget leading = const Icon(Icons.info),
  required String content,
  Color? color,
}) {
  return MaterialBanner(
      backgroundColor: color,
      leading: leading,
      content: Text(content),
      actions: [
        InkWell(
            child: Text('Tutup'),
            onTap: () {
              scaffoldMessengerKey.currentState!.hideCurrentMaterialBanner();
            })
      ]);
}

Future<void> showInfoBanner({required String content}) async {
  Future.delayed(Duration(seconds: 3), () {
    scaffoldMessengerKey.currentState!.hideCurrentMaterialBanner();
  });
  scaffoldMessengerKey.currentState!.showMaterialBanner(
    banner(
      content: content,
    ),
  );
}
