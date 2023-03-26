import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class AdaptiveTextButton extends StatelessWidget {
  final String text;
  final VoidCallback handler;
  AdaptiveTextButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary),
            onPressed: handler,
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
