import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final void Function(BuildContext, FocusNode) onSubmitted;

  AdaptativeTextField(
      {this.label,
      this.keyboardType,
      this.onSubmitted,
      this.textEditingController,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
              placeholder: label,
              controller: textEditingController,
              keyboardType: keyboardType,
              focusNode: focusNode,
              onSubmitted: (_) => onSubmitted(context, focusNode),
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            ),
          )
        : TextField(
            controller: textEditingController,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: label,
            ),
            focusNode: focusNode,
            onSubmitted: (_) => onSubmitted(context, focusNode),
          );
  }
}
