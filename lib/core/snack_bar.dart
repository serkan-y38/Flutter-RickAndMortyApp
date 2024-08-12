import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, String actionText,
    {required Function(void) onActionPressed}) {
  final s = SnackBar(
    content: Text(text),
    action: SnackBarAction(label: actionText, onPressed: () => onActionPressed),
  );
  ScaffoldMessenger.of(context).showSnackBar(s);
}
