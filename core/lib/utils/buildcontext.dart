import 'package:flutter/material.dart';

extension BuildcontextExt on BuildContext {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message,
    bool showCloseIcon,
  ) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        showCloseIcon: showCloseIcon,
      ),
    );
  }
}
