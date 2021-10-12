import 'package:flutter/material.dart';

SnackBar snackbar({
  required String title,
  required String content,
  Color? color,
}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    width: 500,
    backgroundColor: color,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(content),
      ],
    ),
  );
}
