import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final bool overflowEnabled;
  final TextAlign? textAlign;

  const CommonText({
    super.key,
    required this.text,
    this.style,
    this.maxLines,
    this.overflowEnabled = false,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      style: style,
      maxLines: maxLines,
      overflow: overflowEnabled ? TextOverflow.ellipsis : TextOverflow.visible,
      textAlign: textAlign,
    );
  }
}
