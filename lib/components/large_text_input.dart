import 'package:flutter/material.dart';

class LargeTextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextDirection textDirection;
  const LargeTextFieldInput({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    this.textDirection = TextDirection.rtl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: TextInputType.multiline,
      maxLines: null,
      textDirection: textDirection,
      textAlign:
          textDirection == TextDirection.rtl ? TextAlign.right : TextAlign.left,
    );
  }
}
