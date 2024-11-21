import 'package:athendat/features/shared/presentation/widget/app_style.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  const ReusableText(
      {super.key,
      required this.text,
      this.style,
      this.wrap = false,
      this.maxLines = 3,
      this.textAlign = TextAlign.left});

  final String text;
  final TextStyle? style;
  final bool wrap;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AutoSizeText(
      minFontSize: 18,
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: wrap,
      overflow: TextOverflow.fade,
      style: style ??
          appStyle(16, theme.colorScheme.onSecondary, FontWeight.normal),
    );
  }
}
